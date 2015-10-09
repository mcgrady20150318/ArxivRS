//: Playground - noun: a place where people can play

import UIKit

var str = "http://arxiv.org/abs/1505.03933v1"

var a = str.componentsSeparatedByString("/")

var d = a[3]

var b = a[4].componentsSeparatedByString("v")[0]

var c = "http://arxiv.org/\(d)/\(b)"


