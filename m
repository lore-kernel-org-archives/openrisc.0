From: Richard Henderson <rth@twiddle.net>
Date: Thu, 20 Oct 2016 11:34:08 -0700
Subject: [OpenRISC] GCC-optimizations/weirdness...
In-Reply-To: <362afbd6-e548-0370-12c7-9e2b0d384cbe@twiddle.net>
References: <D90E780DD5090A4F9AEBC859615CED77EE1CEE69@OXYGEN.aacmicrotec.local>
 <ae185e23-3459-13f5-9a77-fcbd7d6b1d72@twiddle.net>
 <D90E780DD5090A4F9AEBC859615CED77EE1CF0AC@OXYGEN.aacmicrotec.local>
 <362afbd6-e548-0370-12c7-9e2b0d384cbe@twiddle.net>
Message-ID: <1359fcc3-e216-1ea0-a4aa-fa0cc6877575@twiddle.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 10/20/2016 08:48 AM, Richard Henderson wrote:
> 00000000 <__muldi3>:
>    0:   ba 64 00 50     l.srli r19,r4,0x10
>    4:   b9 66 00 50     l.srli r11,r6,0x10
>    8:   a5 84 ff ff     l.andi r12,r4,0xffff
>    c:   a6 e6 ff ff     l.andi r23,r6,0xffff
>   10:   e2 2c 5b 06     l.mul r17,r12,r11
>   14:   e2 b3 bb 06     l.mul r21,r19,r23
>   18:   e1 73 5b 06     l.mul r11,r19,r11
>   1c:   e2 6c bb 06     l.mul r19,r12,r23
>   20:   e0 84 2b 06     l.mul r4,r4,r5
>   24:   e0 c6 1b 06     l.mul r6,r6,r3
>   28:   19 80 ff ff     l.movhi r12,0xffff
>   2c:   ba f1 00 50     l.srli r23,r17,0x10
>   30:   e2 31 60 03     l.and r17,r17,r12
>   34:   e1 95 60 03     l.and r12,r21,r12
>   38:   b8 b5 00 50     l.srli r5,r21,0x10
>   3c:   e1 8c 88 00     l.add r12,r12,r17
>   40:   e2 37 28 01     l.addc r17,r23,r5
>   44:   e1 8c 98 00     l.add r12,r12,r19
>   48:   e2 71 58 01     l.addc r19,r17,r11
>   4c:   e0 84 98 00     l.add r4,r4,r19
>   50:   44 00 48 00     l.jr r9
>   54:   e1 64 30 00     l.add r11,r4,r6

Bah.  Silly error on my part -- shifts not ands.  But anyway,


r~



diff --git a/include/longlong.h b/include/longlong.h
index 2841d0f..dabcb75 100644
--- a/include/longlong.h
+++ b/include/longlong.h
@@ -909,6 +909,33 @@ extern UDItype __umulsidi3 (USItype, USItype);
      UDItype __s = __a - __b;                                   \
      (sl) = (USItype)__s; (sh) = __s >> 32;                     \
    } while (0)
+/* Unlike the generic version below, make use of carry arithmetic
+   to fold the intermediate multiplies.  */
+#define umul_ppmm(w1, w0, u, v)                                        \
+  do {                                                                 \
+    UWtype __x0, __x1, __x2, __x3, __x1h, __x1l, __x2h, __x2l;         \
+    UHWtype __ul, __vl, __uh, __vh;                                    \
+                                                                       \
+    __ul = __ll_lowpart (u);                                           \
+    __uh = __ll_highpart (u);                                          \
+    __vl = __ll_lowpart (v);                                           \
+    __vh = __ll_highpart (v);                                          \
+                                                                       \
+    __x0 = (UWtype) __ul * __vl;                                       \
+    __x1 = (UWtype) __ul * __vh;                                       \
+    __x2 = (UWtype) __uh * __vl;                                       \
+    __x3 = (UWtype) __uh * __vh;                                       \
+                                                                       \
+    __x1l = __x1 << (W_TYPE_SIZE / 2);                                 \
+    __x2l = __x2 << (W_TYPE_SIZE / 2);                                 \
+    __x1h = __ll_highpart (__x1);                                      \
+    __x2h = __ll_highpart (__x2);                                      \
+                                                                       \
+    add_ssaaaa(__x3, __x0, __x3, __x0, __x1h, __x1l);                  \
+    add_ssaaaa(__x3, __x0, __x3, __x0, __x2h, __x2l);                  \
+    (w1) = __x3;                                                       \
+    (w0) = __x0;                                                       \
+  } while (0)
  #endif /* __OR1K__ */

  /* FIXME: We should test _IBMR2 here when we add assembly support for the


