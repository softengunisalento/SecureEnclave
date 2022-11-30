import Foundation
import MultipeerConnectivity
import os

public class MultipeerSession: NSObject, ObservableObject {
    
    private let serviceType = "service"
    private let session: MCSession
    private let myPeerId = MCPeerID(displayName: UIDevice.current.name)
    private let serviceAdvertiser: MCNearbyServiceAdvertiser
    private let serviceBrowser: MCNearbyServiceBrowser
    private let log = Logger()
    
    @Published private var myString: String = "0"
    @Published private var myArrayString: [String] = []
    @Published private var connectedPeers: [MCPeerID] = []
    
    public override init() {
        precondition(Thread.isMainThread)
        self.session = MCSession(peer: myPeerId)
        self.serviceAdvertiser = MCNearbyServiceAdvertiser(peer: myPeerId, discoveryInfo: nil, serviceType: serviceType)
        self.serviceBrowser = MCNearbyServiceBrowser(peer: myPeerId, serviceType: serviceType)
        super.init()

        session.delegate = self
        serviceAdvertiser.delegate = self
        serviceBrowser.delegate = self

        //serviceAdvertiser.startAdvertisingPeer()
        //serviceBrowser.startBrowsingForPeers()
    }
    
    public func getConnectedPeers() -> [MCPeerID]{
        return connectedPeers
    }
    
    public func getmyString() -> String {
        return myString
    }
    
    public func getmyArrayString() -> [String] {
        return myArrayString
    }
    
    deinit {
        self.serviceAdvertiser.stopAdvertisingPeer()
        self.serviceBrowser.stopBrowsingForPeers()
    }
    
    public func stop(){
        self.serviceAdvertiser.stopAdvertisingPeer()
        self.serviceBrowser.stopBrowsingForPeers()
        self.session.disconnect()
    }
    
    public func start(){
        self.serviceAdvertiser.startAdvertisingPeer()
        self.serviceBrowser.startBrowsingForPeers()
    }
    
    func send(string: String) {
        precondition(Thread.isMainThread)
        log.info("sendString: \(string) to \(self.session.connectedPeers.count) peers")
        //self.myString = string

        if !session.connectedPeers.isEmpty && session.connectedPeers.count < 2{
            do {
                try session.send(string.data(using: .utf8)!, toPeers: session.connectedPeers, with: .reliable)
            } catch {
                log.error("Error for sending: \(String(describing: error))")
            }
        }
        else {
            print("Too much peer in session")
        }
    }
    
    func send(ArrayString: [String]) {
        precondition(Thread.isMainThread)
        //log.info("sendString: \(ArrayString) to \(self.session.connectedPeers.count) peers")
        //self.myString = string

        if !session.connectedPeers.isEmpty && session.connectedPeers.count < 2{
            do {
                try session.send(stringArrayToData(stringArray: ArrayString)!, toPeers: session.connectedPeers, with: .reliable)
            } catch {
                log.error("Error for sending: \(String(describing: error))")
            }
        }
        else {
            print("Connection Error")
        }
    }
    
    public func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        log.error("Receiving streams is not supported")
    }

    public func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        log.error("Receiving resources is not supported")
    }

    public func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        log.error("Receiving resources is not supported")
    }

}


extension MultipeerSession: MCNearbyServiceAdvertiserDelegate {
    public func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
        precondition(Thread.isMainThread)
        log.error("ServiceAdvertiser didNotStartAdvertisingPeer: \(String(describing: error))")
    }

    public func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        precondition(Thread.isMainThread)
        log.info("didReceiveInvitationFromPeer \(peerID)")
        invitationHandler(true, session)
    }
}

extension MultipeerSession: MCNearbyServiceBrowserDelegate {
    public func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        log.error("ServiceBrowser didNotStartBrowsingForPeers: \(String(describing: error))")
    }

    public func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String: String]?) {
        log.info("ServiceBrowser found peer: \(peerID)")
        browser.invitePeer(peerID, to: session, withContext: nil, timeout: 10)
    }

    public func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        log.info("ServiceBrowser lost peer: \(peerID)")
    }
}

extension MultipeerSession: MCSessionDelegate {
    public func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        log.info("peer \(peerID) didChangeState: \(state.debugDescription)")
        DispatchQueue.main.async {
            self.connectedPeers = session.connectedPeers
        }
    }

    /*
    public func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        if let string = String(data: data, encoding: .utf8) {
            log.info("didReceive string \(string)")
            DispatchQueue.main.async {
                self.myString = string
            }
        } else {
            log.info("didReceive invalid value \(data.count) bytes")
        }
    }
     */
    
    public func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        if let arrayString = dataToStringArray(data: data) {
            log.info("didReceive string \(arrayString)")
            DispatchQueue.main.async {
                self.myArrayString = arrayString
                self.myString = String(self.myArrayString.count/2)
            }
        } else {
            log.info("didReceive invalid value \(data.count) bytes")
        }
    }
    
    func stringArrayToData(stringArray: [String]) -> Data? {
      return try? JSONSerialization.data(withJSONObject: stringArray, options: [])
    }
    
    func dataToStringArray(data: Data) -> [String]? {
      return (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String]
    }
    
}

extension MCSessionState: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .notConnected:
            return "notConnected"
        case .connecting:
            return "connecting"
        case .connected:
            return "connected"
        @unknown default:
            return "\(rawValue)"
        }
    }
}
