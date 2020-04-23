#!/bin/bash

case $1 in
  x1q_chn_openx)
    echo G9810
    ;;

  y2q_chn_openx)
    echo G9860
    ;;

  z3q_chn_openx)
    echo G9880
    ;;

  *)
    echo $1
    ;;
esac
