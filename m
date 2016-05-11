From: Philipp Wagner <lists@philipp-wagner.com>
Date: Wed, 11 May 2016 17:17:06 +0200
Subject: [OpenRISC] Fwd: or1k GCC Internal Compiler Error
In-Reply-To: <542B2933.4090402@philipp-wagner.com>
References: <542B2933.4090402@philipp-wagner.com>
Message-ID: <57334CF2.6080700@philipp-wagner.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi,

I've been asked to forward this bug report to the new mailing list; the
bug is still not resolved, so I'd be glad if someone wants to have a
look at it.

Philipp


-------- Forwarded Message --------
Subject: or1k GCC Internal Compiler Error
Date: Wed, 01 Oct 2014 00:05:39 +0200
From: Philipp Wagner <lists@philipp-wagner.com>
To: openrisc@lists.opencores.org

Hi,

we get an Internal Compiler Error (ICE) from the or1k 4.9 and 4.8 GCC
when trying to compile C++ code that makes use of inheritance and
virtual functions. The ICE only occurs if optimization is enabled (-O1
and above), it does *not* happen with -O0. The code also compiles fine
on a regular Ubuntu 14.04 x86_64 GCC 4.8 (probably heavily patched though).

I reduced the attached testcase down to a minimum (it's code from
Fiasco.OC) to show the ICE, but I have no clue what exactly triggers the
problem. Could possibly anybody with more experience in the compiler
field have a look at what might cause the error?

Some free beers at ORConf will be reserved for the solution for that :-)

Philipp



-------------- next part --------------
A non-text attachment was scrubbed...
Name: testcase.cc
Type: text/x-c++src
Size: 2748 bytes
Desc: not available
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20160511/b9055083/attachment.cc>
