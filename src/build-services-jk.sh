#!/bin/bash
#
# Copyright 2017 Istio Authors
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

set -o errexit

if [ "$#" -ne 1 ]; then
    echo Missing version parameter
    echo Usage: build-services.sh \<version\>
    exit 1
fi

VERSION=$1
PREFIX=$2
SCRIPTDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

pushd "$SCRIPTDIR/productpage"
  aws ecr get-login-password --region ap-northeast-2 | docker login --username AWS --password-stdin 424202621926.dkr.ecr.ap-northeast-2.amazonaws.com
  docker build -t jk-ecr-repository/productpage-v1 .
  docker tag jk-ecr-repository/productpage-v1:latest 424202621926.dkr.ecr.ap-northeast-2.amazonaws.com/jk-ecr-repository/productpage-v1:latest
  docker push 424202621926.dkr.ecr.ap-northeast-2.amazonaws.com/jk-ecr-repository/productpage-v1:latest
popd


# pushd "$SCRIPTDIR/details"
#   aws ecr get-login-password --region ap-northeast-2 | docker login --username AWS --password-stdin 424202621926.dkr.ecr.ap-northeast-2.amazonaws.com
#   docker build -t jk-ecr-repository/details-v1 --build-arg service_version=v1 .
#   docker tag jk-ecr-repository/details-v1:latest 424202621926.dkr.ecr.ap-northeast-2.amazonaws.com/jk-ecr-repository/details-v1:latest
#   docker push 424202621926.dkr.ecr.ap-northeast-2.amazonaws.com/jk-ecr-repository/details-v1:latest
# popd


# pushd "$SCRIPTDIR/reviews"
#   aws ecr get-login-password --region ap-northeast-2 | docker login --username AWS --password-stdin 424202621926.dkr.ecr.ap-northeast-2.amazonaws.com
#   docker run --rm -v "$(pwd)":/home/gradle/project -w /home/gradle/project gradle:4.8.1 gradle clean build
#   pushd reviews-wlpcfg
#     docker build -t jk-ecr-repository/reviews-v1 --build-arg service_version=v2 \
#     --build-arg enable_ratings=true .
#     docker tag jk-ecr-repository/reviews-v1:latest 424202621926.dkr.ecr.ap-northeast-2.amazonaws.com/jk-ecr-repository/reviews-v1:latest
#     docker push 424202621926.dkr.ecr.ap-northeast-2.amazonaws.com/jk-ecr-repository/reviews-v1:latest
    
#     docker build -t jk-ecr-repository/reviews-v2  --build-arg service_version=v3 \
#     --build-arg enable_ratings=true --build-arg star_color=red .
#     docker tag jk-ecr-repository/reviews-v2:latest 424202621926.dkr.ecr.ap-northeast-2.amazonaws.com/jk-ecr-repository/reviews-v2:latest
#     docker push 424202621926.dkr.ecr.ap-northeast-2.amazonaws.com/jk-ecr-repository/reviews-v2:latest
#   popd
# popd


# pushd "$SCRIPTDIR/ratings"
#   aws ecr get-login-password --region ap-northeast-2 | docker login --username AWS --password-stdin 424202621926.dkr.ecr.ap-northeast-2.amazonaws.com
#   docker build -t jk-ecr-repository/ratings-v1 --build-arg service_version=v1 .
#   docker tag jk-ecr-repository/ratings-v1:latest 424202621926.dkr.ecr.ap-northeast-2.amazonaws.com/jk-ecr-repository/ratings-v1:latest
#   docker push 424202621926.dkr.ecr.ap-northeast-2.amazonaws.com/jk-ecr-repository/ratings-v1:latest
# popd