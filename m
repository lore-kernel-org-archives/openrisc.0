From: Richard Henderson <rth@twiddle.net>
Date: Wed, 11 Jul 2018 08:28:15 -0700
Subject: [OpenRISC] GCC testing and dynamic linker
In-Reply-To: <20180711144943.GA9742@lianli.shorne-pla.net>
References: <20180711144943.GA9742@lianli.shorne-pla.net>
Message-ID: <4B4D66F3-A47B-4666-B9B1-8B988422DBA1@twiddle.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Please do. I think that's a remenent of a misconfigured linker, once upon a midnight weary, and accidentally carried over to the new port.


r~


>I have a question, I noticed in `gcc\config\or1k\linux.h` you have put:
>
>  #define MUSL_DYNAMIC_LINKER  "/lib/ld.so.1"
>
>It seems musl produces the file as `ld-musl-or1k.so.1`.  Do you mind if
>I change
>it?
>
>-Stafford

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
