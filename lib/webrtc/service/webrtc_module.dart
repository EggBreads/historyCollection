import 'package:flutter_webrtc/flutter_webrtc.dart';

class WebrtcSignal {
  // Peer 연결 객체
  RTCPeerConnection? peer;

  // Data 전송 채널
  RTCDataChannel? localDataChannel;

  RTCSessionDescription? localOffer;

  RTCSessionDescription? remoteOffer;

  /// 본인 비디오 렌더러
  // RTCVideoRenderer? localRenderer = RTCVideoRenderer();

  // /// 상대방 비디오 렌더러
  // RTCVideoRenderer? remoteRenderer = RTCVideoRenderer();

  // /// 본인 비디오 렌더 상태관리
  // ValueNotifier<bool> localVideoNotifier = ValueNotifier<bool>(false);

  // /// 상대방 비디오 렌더 상태관리
  // ValueNotifier<bool> remoteVideoNotifier = ValueNotifier<bool>(false);

  /// iceCandidate 연결 여부
  // final bool _isConnected = false;

  Future<void> connectPeer() async {
    peer = await createPeerConnection(
      {
        'iceServers': [
          {
            'url': 'stun:stun.l.google.com:19302',
          },
        ],
      },
    );
  }

  // LocalChannel 생성
  Future<void> setDataChannel(String label) async {
    localDataChannel = await peer?.createDataChannel(
      label,
      RTCDataChannelInit()..negotiated = true,
    );
  }

  // LocalOffer 생성
  Future<void> setLocaltOffer() async {
    localOffer = await peer?.createOffer();

    if (localOffer == null) {
      return;
    }

    await peer?.setLocalDescription(localOffer!);
  }

  Future<void> setRemoteOffer(String sdp, String type) async {
    final remoteOffer = RTCSessionDescription(sdp, type);

    await peer?.setRemoteDescription(remoteOffer);
  }

  // Future<void> initWebrtc();

  // Future<void> sendLocalOffer();
}
