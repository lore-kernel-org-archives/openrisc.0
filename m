From: Andrew Burgess <andrew.burgess@embecosm.com>
Date: Thu, 11 Apr 2019 23:27:49 +0100
Subject: [OpenRISC] [PATCH v2 6/6] sim/common: Fix issue with wrong byte
 order on BE targets
In-Reply-To: <20190409213925.32699-7-shorne@gmail.com>
References: <20190409213925.32699-1-shorne@gmail.com>
 <20190409213925.32699-7-shorne@gmail.com>
Message-ID: <20190411222749.GB2737@embecosm.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

* Stafford Horne <shorne@gmail.com> [2019-04-10 06:39:25 +0900]:

> Currently only the OpenRISC sim uses this JOINSIDF() function to compose a
> double float from 2 registers.  The old code doesn't seem to work as the
> work order gets swapped when running on a x86_64 host.  This change
> fixes that, but I am not sure if its the best thing to do.
> 
> On mips they do similar reg pair floating point operations composing
> doubles from 2 32-bit registers in sim/mips/cp1.c value_fpr().
> 
> sim/common/ChangeLog:
> 
> 	* cgen-ops.h (JOINSIDF): Fix big endian check.
> ---
>  sim/common/cgen-ops.h | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/sim/common/cgen-ops.h b/sim/common/cgen-ops.h
> index 841552066f..d718394723 100644
> --- a/sim/common/cgen-ops.h
> +++ b/sim/common/cgen-ops.h
> @@ -431,12 +431,8 @@ JOINSIDI (SI x0, SI x1)
>  SEMOPS_INLINE DF
>  JOINSIDF (SI x0, SI x1)
>  {
> -  union { SI in[2]; DF out; } x;
> -  if (CURRENT_TARGET_BYTE_ORDER == BFD_ENDIAN_BIG)

I think this is the problem with the existing code, we're using memory
on the HOST to perform packing / unpacking, and so its the byte
ordering of the HOST that we care about here, not the target.

If I change the above line to instead be:

     if (HOST_BYTE_ORDER == BFD_ENDIAN_BIG)

then everything works fine.

On inspection I believe all of the uses of CURRENT_TARGET_BYTE_ORDER
in this file should be similarly replaced.

I've attached a patch for this change.  If you agree I'll go ahead and
push it.

Thanks,
Andrew


--

[PATCH] sim: Use host not target byte order for merging and splitting values

When using writes to memory through a struct to merge and extract
multi-word value, it is the endianness of the host, not the target
that affects which order the component words need to be written into
the structure.

Of the 5 functions adjusted here 4 of them are unused.  The 5th,
JOINSIDF will soon be used by the or1k target.

For or1k, simulated on x86-64, this change fixes this function so that
the correct bytes are now returned.

sim/common/ChangeLog:

	* cgen-ops.h (SUBWORDXFSI): Compare HOST_BYTE_ORDER not
	CURRENT_TARGET_BYTE_ORDER.
	(SUBWORDTFSI): Likewise.
	(JOINSIDF): Likewise.
	(JOINSIXF): Likewise.
	(JOINSITF): Likewise.
---
 sim/common/ChangeLog  |  9 +++++++++
 sim/common/cgen-ops.h | 10 +++++-----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/sim/common/cgen-ops.h b/sim/common/cgen-ops.h
index 841552066f4..6fecb862a8a 100644
--- a/sim/common/cgen-ops.h
+++ b/sim/common/cgen-ops.h
@@ -404,7 +404,7 @@ SUBWORDXFSI (XF in, int word)
   /* Note: typedef struct { SI parts[3]; } XF; */
   union { XF in; SI out[3]; } x;
   x.in = in;
-  if (CURRENT_TARGET_BYTE_ORDER == BFD_ENDIAN_BIG)
+  if (HOST_BYTE_ORDER == BFD_ENDIAN_BIG)
     return x.out[word];
   else
     return x.out[2 - word];
@@ -416,7 +416,7 @@ SUBWORDTFSI (TF in, int word)
   /* Note: typedef struct { SI parts[4]; } TF; */
   union { TF in; SI out[4]; } x;
   x.in = in;
-  if (CURRENT_TARGET_BYTE_ORDER == BFD_ENDIAN_BIG)
+  if (HOST_BYTE_ORDER == BFD_ENDIAN_BIG)
     return x.out[word];
   else
     return x.out[3 - word];
@@ -432,7 +432,7 @@ SEMOPS_INLINE DF
 JOINSIDF (SI x0, SI x1)
 {
   union { SI in[2]; DF out; } x;
-  if (CURRENT_TARGET_BYTE_ORDER == BFD_ENDIAN_BIG)
+  if (HOST_BYTE_ORDER == BFD_ENDIAN_BIG)
     x.in[0] = x0, x.in[1] = x1;
   else
     x.in[1] = x0, x.in[0] = x1;
@@ -443,7 +443,7 @@ SEMOPS_INLINE XF
 JOINSIXF (SI x0, SI x1, SI x2)
 {
   union { SI in[3]; XF out; } x;
-  if (CURRENT_TARGET_BYTE_ORDER == BFD_ENDIAN_BIG)
+  if (HOST_BYTE_ORDER == BFD_ENDIAN_BIG)
     x.in[0] = x0, x.in[1] = x1, x.in[2] = x2;
   else
     x.in[2] = x0, x.in[1] = x1, x.in[0] = x2;
@@ -454,7 +454,7 @@ SEMOPS_INLINE TF
 JOINSITF (SI x0, SI x1, SI x2, SI x3)
 {
   union { SI in[4]; TF out; } x;
-  if (CURRENT_TARGET_BYTE_ORDER == BFD_ENDIAN_BIG)
+  if (HOST_BYTE_ORDER == BFD_ENDIAN_BIG)
     x.in[0] = x0, x.in[1] = x1, x.in[2] = x2, x.in[3] = x3;
   else
     x.in[3] = x0, x.in[2] = x1, x.in[1] = x2, x.in[0] = x3;
-- 
2.14.5

