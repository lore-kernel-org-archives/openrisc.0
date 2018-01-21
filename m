From: Richard Henderson <rth@twiddle.net>
Date: Sat, 20 Jan 2018 20:28:20 -0800
Subject: [OpenRISC] OpenRISC GCC upstream plan
In-Reply-To: <20180120133654.GH13019@lianli.shorne-pla.net>
References: <20180101125546.GH32243@lianli.shorne-pla.net>
 <c6104ef7-0dba-fcd7-e57e-f925b85fc553@twiddle.net>
 <20180103153211.GK32243@lianli.shorne-pla.net>
 <c800d6ef-bfea-7c1d-5237-b373fd085422@twiddle.net>
 <20180120133654.GH13019@lianli.shorne-pla.net>
Message-ID: <05ed4fd2-7689-c969-2fd4-2003e1c4d181@twiddle.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 01/20/2018 05:36 AM, Stafford Horne wrote:
> Some comments on the binutils patches:
> 
>  - There was one issue with your l.maci fixes which I patched here [2]
>  - The summary of changes (for others) are
>   1 Add relocations for Adjusted High (signed) and Split Low (store isns)
>   2 Add relocations for l.adrp page relative types (new instruction)
>   3 Add missing (l.muld, l.muldu, l.macu, l.msbu) instructions
>   4 Add 64-bit Relocations
>   5 Add 64-bit Load/Store instructions
>  - If we are currently not supporting 64 bit cores, do we need 4 and 5?  Do
>    maybe other people have a say.  I am considering dropping them for
>    simplicity.

No, 4 & 5 are only needed if you're trying to minimally support 64-bit.  I did
attempt 64-bit support at one point, and dropped it from both sim and gcc.


r~
