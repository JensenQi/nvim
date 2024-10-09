#!/bin/sh

echo "密钥库口令"
read storepass

echo "密钥口令 (默认密钥库口令)"
read keypass
if [ "$keypass" = "" ]; then
    keypass=$storepass
fi

echo "密钥库路径 (keystore, default /${USER}/.android/release.keystore）"
read keystore
if [ "$keystore" = "" ]; then
    keystore="/${USER}/.android/release.keystore"
fi


echo "密钥别名 (默认 release)"
read keyalias
if [ "$keyalias" = "" ]; then
    keyalias="release"
fi


echo "有效天数 (默认 1461)"
read validity
if [ "$validity" = "" ]; then
    validity="1461"
fi

echo "域名 (默认 cuda.tech)"
read common_name
if [ "$common_name" = "" ]; then
    common_name="cuda.tech"
fi

echo "单位 (默认 cuda.tech Inc.)"
read org_unit
if [ "$org_unit" = "" ]; then
    org_unit="cuda.tech Inc."
fi

echo "组织 (默认 CudaTech Inc.)"
read org_name
if [ "$org_name" = "" ]; then
    org_name="CudaTech Inc."
fi

echo "城市 (默认 Shanghai)"
read locality_name
if [ "$locality_name" = "" ]; then
    locality_name="Shanghai"
fi

echo "省份 (默认 Shanghai)"
read state_name
if [ "$state_name" = "" ]; then
    state_name="Shanghai"
fi

echo "国家 (默认 CN)"
read country
if [ "$country" = "" ]; then
    country="CN"
fi

keytool -genkey \
    -keyalg RSA \
    -keystore ${keystore} \
    -storepass ${storepass} \
    -alias ${keyalias} \
    -keypass ${keypass} \
    -dname "CN=${common_name},OU=${org_unit},O=${org_name},L=${locality_name},ST=${state_name},C=${country}" \
    -validity ${validity} 

echo "export ANDROID_RELEASE_STORE_FILE=${keystore}"
echo "export ANDROID_RELEASE_STORE_PASSWORD=${storepass}"
echo "export ANDROID_RELEASE_KEY_ALIAS=${keyalias}"
echo "export ANDROID_RELEASE_KEY_PASSWORD=${keypass}"
