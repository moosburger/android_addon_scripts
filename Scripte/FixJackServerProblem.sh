#!/bin/bash

    grep -Eoi 'jdk.tls.disabledAlgorithms.*' /etc/java-8-openjdk/security/java.security
    searchString="TLSv1, TLSv1.1, "
    replaceWith=""
    sed -i -e "s:${searchString}:${replaceWith}:g" /etc/java-8-openjdk/security/java.security
    grep -Eoi 'jdk.tls.disabledAlgorithms.*' /etc/java-8-openjdk/security/java.security
