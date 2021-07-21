{ callPackage, deepspeech }: rec {
  dataclasses-json = callPackage ./dataclasses-json {
    inherit typing-inspect;
  };

  grapheme = callPackage ./grapheme {
  };

  hypercorn = callPackage ./hypercorn { };

  quart = callPackage ./quart {
    inherit hypercorn;
  };

  quart-cors = callPackage ./quart-cors {
    inherit quart;
  };

  rapidfuzz = callPackage ./rapidfuzz { };

  rhasspy-hermes = callPackage ./rhasspy-hermes {
    inherit dataclasses-json;
  };

  rhasspy-asr = callPackage ./rhasspy-asr { };

  rhasspy-asr-deepspeech = callPackage ./rhasspy-asr-deepspeech {
    inherit rhasspy-asr rhasspy-nlu deepspeech;
  };

  rhasspy-asr-deepspeech-hermes = callPackage ./rhasspy-asr-deepspeech-hermes {
    inherit rhasspy-hermes rhasspy-asr-deepspeech rhasspy-silence;
  };

  rhasspy-asr-kaldi = callPackage ./rhasspy-asr-kaldi {
    inherit rhasspy-asr rhasspy-nlu;
  };

  rhasspy-asr-kaldi-hermes = callPackage ./rhasspy-asr-kaldi-hermes {
    inherit rhasspy-hermes rhasspy-asr-kaldi rhasspy-silence;
  };

  rhasspy-fuzzywuzzy = callPackage ./rhasspy-fuzzywuzzy {
    inherit rhasspy-nlu rapidfuzz;
  };

  rhasspy-fuzzywuzzy-hermes = callPackage ./rhasspy-fuzzywuzzy-hermes {
    inherit rhasspy-fuzzywuzzy rhasspy-hermes rhasspy-nlu;
  };

  rhasspy-microphone-pyaudio-hermes = callPackage ./rhasspy-microphone-pyaudio-hermes {
    inherit rhasspy-hermes;
  };

  rhasspy-nlu = callPackage ./rhasspy-nlu {
    inherit grapheme;
  };

  rhasspy-remote-http-hermes = callPackage ./rhasspy-remote-http-hermes {
    inherit rhasspy-hermes rhasspy-nlu rhasspy-silence;
  };

  rhasspy-silence = callPackage ./rhasspy-silence { };

  rhasspy-tts-cli-hermes = callPackage ./rhasspy-tts-cli-hermes {
    inherit rhasspy-hermes;
  };

  rhasspy-wake-porcupine-hermes = callPackage ./rhasspy-wake-porcupine-hermes {
    inherit rhasspy-hermes pvporcupine;
  };

  rhasspy-wake-raven = callPackage ./rhasspy-wake-raven {
    inherit rhasspy-silence python_speech_features;
  };

  rhasspy-wake-raven-hermes = callPackage ./rhasspy-wake-raven-hermes {
    inherit rhasspy-wake-raven rhasspy-hermes;
  };

  rhasspy-wake-snowboy-hermes = callPackage ./rhasspy-wake-snowboy-hermes {
    inherit rhasspy-hermes;
  };

  rhasspy-dialogue-hermes = callPackage ./rhasspy-dialogue-hermes {
    inherit rhasspy-hermes;
  };

  rhasspy-speakers-cli-hermes = callPackage ./rhasspy-speakers-cli-hermes {
    inherit rhasspy-hermes wavchunk;
  };

  rhasspy-microphone-cli-hermes = callPackage ./rhasspy-microphone-cli-hermes {
    inherit rhasspy-hermes;
  };

  rhasspy-rasa-nlu-hermes = callPackage ./rhasspy-rasa-nlu-hermes {
    inherit rhasspy-hermes rhasspy-nlu;
  };

  rhasspy-nlu-hermes = callPackage ./rhasspy-nlu-hermes {
    inherit rhasspy-hermes rhasspy-nlu;
  };

  rhasspy-homeassistant-hermes = callPackage ./rhasspy-homeassistant-hermes {
    inherit rhasspy-hermes;
  };

  pydash = callPackage ./pydash { };

  python_speech_features = callPackage ./python_speech_features { };

  json5 = callPackage ./json5 { };

  rhasspy-profile = callPackage ./rhasspy-profile {
    inherit pydash json5 dataclasses-json;
  };

  rhasspy-supervisor = callPackage ./rhasspy-supervisor {
    inherit rhasspy-profile;
  };

  rhasspy-server-hermes = callPackage ./rhasspy-server-hermes {
    inherit rhasspy-hermes
      rhasspy-profile
      rhasspy-nlu
      swagger-ui-py
      rhasspy-supervisor
      quart
      quart-cors;
  };

  rhasspy = callPackage ./rhasspy {
    inherit
      rhasspy-asr-deepspeech-hermes
      rhasspy-asr-kaldi-hermes
      rhasspy-dialogue-hermes
      rhasspy-tts-cli-hermes
      rhasspy-wake-porcupine-hermes
      rhasspy-wake-raven-hermes
      rhasspy-wake-snowboy-hermes
      rhasspy-remote-http-hermes
      rhasspy-fuzzywuzzy-hermes
      rhasspy-speakers-cli-hermes
      rhasspy-microphone-cli-hermes
      rhasspy-microphone-pyaudio-hermes
      rhasspy-nlu-hermes
      rhasspy-homeassistant-hermes
      rhasspy-supervisor
      rhasspy-server-hermes
      ;
  };

  swagger-ui-py = callPackage ./swagger-ui-py { };

  wavchunk = callPackage ./wavchunk { };

  pvporcupine = callPackage ./pvporcupine { };

  typing-inspect = callPackage ./typing-inspect { };
}
