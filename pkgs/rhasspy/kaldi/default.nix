{ stdenv
, openblas
, blas
, lapack
, openfst
, icu
, cmake
, pkgconfig
, fetchFromGitHub
, breakpointHook
, git
, strace
}:

assert blas.implementation == "openblas" && lapack.implementation == "openblas";

let
  # rev from https://github.com/kaldi-asr/kaldi/blob/master/cmake/third_party/openfst.cmake
  openfst = fetchFromGitHub {
    owner = "kkm000";
    repo = "openfst";
    rev = "0bca6e76d24647427356dc242b0adbf3b5f1a8d9";
    sha256 = "1802rr14a03zl1wa5a0x1fa412kcvbgprgkadfj5s6s3agnn11rx";
  };
in stdenv.mkDerivation {
  pname = "kaldi";
  version = "2020-06-06";

  src = fetchFromGitHub {
    owner = "kaldi-asr";
    repo = "kaldi";
    rev = "c9d8b9ad3fef89237ba5517617d977b7d70a7ed5";
    sha256 = "1m8lzh3wilrwd1k5zjzaax0z7n9bxm9ss3ckr31ybb43x5kgx7jy";
  };

  cmakeFlags = [ "-DKALDI_BUILD_TEST=off" "-DBUILD_SHARED_LIBS=on" ];
  preConfigure = ''
    mkdir build
    mkdir bin
    cat > bin/git <<'EOF'
    #!${stdenv.shell}
    if [[ "$1" == "--version" ]]; then
      # cmake checks this
      ${git}/bin/git --version
    elif [[ "$1" == "clone" ]]; then
      # mock this call:
      # https://github.com/kaldi-asr/kaldi/blob/c9d8b9ad3fef89237ba5517617d977b7d70a7ed5/cmake/third_party/openfst.cmake#L5
      cp -r ${openfst} ''${@: -1}
      chmod -R +w ''${@: -1}
    elif [[ "$1" == "rev-list" ]]; then
      # fix up this call:
      # https://github.com/kaldi-asr/kaldi/blob/c9d8b9ad3fef89237ba5517617d977b7d70a7ed5/cmake/VersionHelper.cmake#L8
      echo 0
    fi
    true
    EOF
    chmod +x bin/git
    cat src/.version
    export PATH=$(pwd)/bin:$PATH

    mkdir -p $out/share/kaldi
    cp -r egs $out/share/kaldi
  '';

  buildInputs = [
    openblas
    openfst
    icu
  ];

  nativeBuildInputs = [
    cmake
    pkgconfig
  ];

  postInstall = ''
  '';
  #  mkdir -p "${dist_dir}/kaldi/egs" && \
  #  cp -R "${kaldi_build}/egs/wsj" "${dist_dir}/kaldi/egs/" && \
  #  rsync -av --exclude='*.o' --exclude='*.cc' "${kaldi_build}/src/bin/" "${dist_dir}/kaldi/" && \
  #  cp "${kaldi_build}/src/lib"/*.so* "${dist_dir}/kaldi/" && \
  #  rsync -av --include='*.so*' --include='fst' --exclude='*' "${kaldi_build}/tools/openfst/lib/" "${dist_dir}/kaldi/" && \
  #  cp "${kaldi_build}/tools/openfst/bin/" "${dist_dir}/kaldi/"

  meta = with stdenv.lib; {
    description = "Speech Recognition Toolkit";
    homepage = "https://kaldi-asr.org";
    license = licenses.mit;
    maintainers = with maintainers; [ mic92 ];
    platforms = platforms.unix;
  };
}
