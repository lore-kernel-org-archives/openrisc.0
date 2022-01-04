From: Stafford Horne <shorne@gmail.com>
Date: Tue,  4 Jan 2022 12:14:08 +0900
Subject: [OpenRISC] [PATCH v5 07/13] or1k: math soft float support
In-Reply-To: <20220104031414.2416928-1-shorne@gmail.com>
References: <20220104031414.2416928-1-shorne@gmail.com>
Message-ID: <20220104031414.2416928-8-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

OpenRISC support hard float but I will like to submit that after glibc
soft float goes upstream.  The hard float support depends on adding user
access to the FPCSR, which is not supported by the kernel yet.

Reviewed-by: Adhemerval Zanella  <adhemerval.zanella@linaro.org>
---
 sysdeps/or1k/bits/fenv.h                   |   69 ++
 sysdeps/or1k/libm-test-ulps                | 1112 ++++++++++++++++++++
 sysdeps/or1k/libm-test-ulps-name           |    1 +
 sysdeps/or1k/nofpu/math-tests-exceptions.h |   29 +
 sysdeps/or1k/nofpu/math-tests-rounding.h   |   28 +
 sysdeps/or1k/sfp-machine.h                 |   93 ++
 sysdeps/or1k/tininess.h                    |    1 +
 7 files changed, 1333 insertions(+)
 create mode 100644 sysdeps/or1k/bits/fenv.h
 create mode 100644 sysdeps/or1k/libm-test-ulps
 create mode 100644 sysdeps/or1k/libm-test-ulps-name
 create mode 100644 sysdeps/or1k/nofpu/math-tests-exceptions.h
 create mode 100644 sysdeps/or1k/nofpu/math-tests-rounding.h
 create mode 100644 sysdeps/or1k/sfp-machine.h
 create mode 100644 sysdeps/or1k/tininess.h

diff --git a/sysdeps/or1k/bits/fenv.h b/sysdeps/or1k/bits/fenv.h
new file mode 100644
index 0000000000..156954c024
--- /dev/null
+++ b/sysdeps/or1k/bits/fenv.h
@@ -0,0 +1,69 @@
+/* Floating point environment, OpenRISC version.
+   Copyright (C) 2022 Free Software Foundation, Inc.
+
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public License as
+   published by the Free Software Foundation; either version 2.1 of the
+   License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#ifndef _FENV_H
+# error "Never use <bits/fenv.h> directly; include <fenv.h> instead."
+#endif
+
+/* Define bits representing exceptions in the FPCSR status word.  */
+enum
+  {
+    FE_OVERFLOW =
+#define FE_OVERFLOW	(1 << 3)
+      FE_OVERFLOW,
+    FE_UNDERFLOW =
+#define FE_UNDERFLOW	(1 << 4)
+      FE_UNDERFLOW,
+    FE_INEXACT =
+#define FE_INEXACT	(1 << 8)
+      FE_INEXACT,
+    FE_INVALID =
+#define FE_INVALID	(1 << 9)
+      FE_INVALID,
+    FE_DIVBYZERO =
+#define FE_DIVBYZERO	(1 << 11)
+      FE_DIVBYZERO,
+  };
+
+/* All supported exceptions.  */
+#define FE_ALL_EXCEPT	\
+	(FE_INVALID | FE_DIVBYZERO | FE_OVERFLOW | FE_UNDERFLOW | FE_INEXACT)
+
+/* Define bits representing rounding modes in the FPCSR Rmode field.  */
+#define FE_TONEAREST  (0x0 << 1)
+#define FE_TOWARDZERO (0x1 << 1)
+#define FE_UPWARD     (0x2 << 1)
+#define FE_DOWNWARD   (0x3 << 1)
+
+/* Type representing exception flags.  */
+typedef unsigned int fexcept_t;
+
+/* Type representing floating-point environment.  */
+typedef unsigned int fenv_t;
+
+/* If the default argument is used we use this value.  */
+#define FE_DFL_ENV	((const fenv_t *) -1l)
+
+#if __GLIBC_USE (IEC_60559_BFP_EXT)
+/* Type representing floating-point control modes.  */
+typedef unsigned int femode_t;
+
+/* Default floating-point control modes.  */
+# define FE_DFL_MODE	((const femode_t *) -1L)
+#endif
diff --git a/sysdeps/or1k/libm-test-ulps b/sysdeps/or1k/libm-test-ulps
new file mode 100644
index 0000000000..94b383669d
--- /dev/null
+++ b/sysdeps/or1k/libm-test-ulps
@@ -0,0 +1,1112 @@
+# Begin of automatic generation
+
+# Maximal error of functions:
+Function: "acos":
+double: 1
+float: 1
+
+Function: "acos_downward":
+double: 1
+float: 1
+
+Function: "acos_towardzero":
+double: 1
+float: 1
+
+Function: "acos_upward":
+double: 1
+float: 1
+
+Function: "acosh":
+double: 2
+float: 2
+
+Function: "acosh_downward":
+double: 2
+float: 2
+
+Function: "acosh_towardzero":
+double: 2
+float: 2
+
+Function: "acosh_upward":
+double: 2
+float: 2
+
+Function: "asin":
+double: 1
+float: 1
+
+Function: "asin_downward":
+double: 1
+float: 1
+
+Function: "asin_towardzero":
+double: 1
+float: 1
+
+Function: "asin_upward":
+double: 1
+float: 1
+
+Function: "asinh":
+double: 2
+float: 2
+
+Function: "asinh_downward":
+double: 3
+float: 3
+
+Function: "asinh_towardzero":
+double: 2
+float: 2
+
+Function: "asinh_upward":
+double: 3
+float: 3
+
+Function: "atan":
+double: 1
+float: 1
+
+Function: "atan2":
+float: 2
+
+Function: "atan2_downward":
+double: 5
+float: 2
+
+Function: "atan2_towardzero":
+double: 5
+float: 2
+
+Function: "atan2_upward":
+double: 8
+float: 2
+
+Function: "atan_downward":
+double: 1
+float: 2
+
+Function: "atan_towardzero":
+double: 1
+float: 1
+
+Function: "atan_upward":
+double: 1
+float: 2
+
+Function: "atanh":
+double: 2
+float: 2
+
+Function: "atanh_downward":
+double: 3
+float: 3
+
+Function: "atanh_towardzero":
+double: 2
+float: 2
+
+Function: "atanh_upward":
+double: 3
+float: 3
+
+Function: "cabs":
+double: 1
+
+Function: "cabs_downward":
+double: 1
+
+Function: "cabs_towardzero":
+double: 1
+
+Function: "cabs_upward":
+double: 1
+
+Function: Real part of "cacos":
+double: 1
+float: 2
+
+Function: Imaginary part of "cacos":
+double: 2
+float: 2
+
+Function: Real part of "cacos_downward":
+double: 3
+float: 2
+
+Function: Imaginary part of "cacos_downward":
+double: 5
+float: 3
+
+Function: Real part of "cacos_towardzero":
+double: 3
+float: 2
+
+Function: Imaginary part of "cacos_towardzero":
+double: 4
+float: 2
+
+Function: Real part of "cacos_upward":
+double: 2
+float: 2
+
+Function: Imaginary part of "cacos_upward":
+double: 5
+float: 7
+
+Function: Real part of "cacosh":
+double: 2
+float: 2
+
+Function: Imaginary part of "cacosh":
+double: 1
+float: 2
+
+Function: Real part of "cacosh_downward":
+double: 4
+float: 2
+
+Function: Imaginary part of "cacosh_downward":
+double: 3
+float: 3
+
+Function: Real part of "cacosh_towardzero":
+double: 4
+float: 2
+
+Function: Imaginary part of "cacosh_towardzero":
+double: 3
+float: 2
+
+Function: Real part of "cacosh_upward":
+double: 4
+float: 3
+
+Function: Imaginary part of "cacosh_upward":
+double: 3
+float: 2
+
+Function: "carg":
+float: 1
+
+Function: "carg_downward":
+double: 5
+float: 2
+
+Function: "carg_towardzero":
+double: 5
+float: 2
+
+Function: "carg_upward":
+double: 8
+float: 2
+
+Function: Real part of "casin":
+double: 1
+float: 1
+
+Function: Imaginary part of "casin":
+double: 2
+float: 2
+
+Function: Real part of "casin_downward":
+double: 3
+float: 2
+
+Function: Imaginary part of "casin_downward":
+double: 5
+float: 3
+
+Function: Real part of "casin_towardzero":
+double: 3
+float: 1
+
+Function: Imaginary part of "casin_towardzero":
+double: 4
+float: 2
+
+Function: Real part of "casin_upward":
+double: 3
+float: 2
+
+Function: Imaginary part of "casin_upward":
+double: 5
+float: 7
+
+Function: Real part of "casinh":
+double: 2
+float: 2
+
+Function: Imaginary part of "casinh":
+double: 1
+float: 1
+
+Function: Real part of "casinh_downward":
+double: 5
+float: 3
+
+Function: Imaginary part of "casinh_downward":
+double: 3
+float: 2
+
+Function: Real part of "casinh_towardzero":
+double: 4
+float: 2
+
+Function: Imaginary part of "casinh_towardzero":
+double: 3
+float: 1
+
+Function: Real part of "casinh_upward":
+double: 5
+float: 7
+
+Function: Imaginary part of "casinh_upward":
+double: 3
+float: 2
+
+Function: Real part of "catan":
+double: 1
+float: 1
+
+Function: Imaginary part of "catan":
+double: 1
+float: 1
+
+Function: Real part of "catan_downward":
+double: 1
+float: 2
+
+Function: Imaginary part of "catan_downward":
+double: 2
+float: 2
+
+Function: Real part of "catan_towardzero":
+double: 1
+float: 2
+
+Function: Imaginary part of "catan_towardzero":
+double: 2
+float: 2
+
+Function: Real part of "catan_upward":
+double: 2
+float: 1
+
+Function: Imaginary part of "catan_upward":
+double: 2
+float: 2
+
+Function: Real part of "catanh":
+double: 1
+float: 1
+
+Function: Imaginary part of "catanh":
+double: 1
+float: 1
+
+Function: Real part of "catanh_downward":
+double: 2
+float: 2
+
+Function: Imaginary part of "catanh_downward":
+double: 1
+float: 2
+
+Function: Real part of "catanh_towardzero":
+double: 2
+float: 2
+
+Function: Imaginary part of "catanh_towardzero":
+double: 1
+float: 2
+
+Function: Real part of "catanh_upward":
+double: 4
+float: 4
+
+Function: Imaginary part of "catanh_upward":
+double: 2
+float: 1
+
+Function: "cbrt":
+double: 4
+float: 1
+
+Function: "cbrt_downward":
+double: 4
+float: 1
+
+Function: "cbrt_towardzero":
+double: 3
+float: 1
+
+Function: "cbrt_upward":
+double: 5
+float: 1
+
+Function: Real part of "ccos":
+double: 1
+float: 1
+
+Function: Imaginary part of "ccos":
+double: 1
+float: 1
+
+Function: Real part of "ccos_downward":
+double: 3
+float: 1
+
+Function: Imaginary part of "ccos_downward":
+double: 3
+float: 3
+
+Function: Real part of "ccos_towardzero":
+double: 3
+float: 2
+
+Function: Imaginary part of "ccos_towardzero":
+double: 3
+float: 3
+
+Function: Real part of "ccos_upward":
+double: 1
+float: 2
+
+Function: Imaginary part of "ccos_upward":
+double: 2
+float: 2
+
+Function: Real part of "ccosh":
+double: 2
+float: 1
+
+Function: Imaginary part of "ccosh":
+double: 1
+float: 1
+
+Function: Real part of "ccosh_downward":
+double: 3
+float: 2
+
+Function: Imaginary part of "ccosh_downward":
+double: 3
+float: 3
+
+Function: Real part of "ccosh_towardzero":
+double: 3
+float: 3
+
+Function: Imaginary part of "ccosh_towardzero":
+double: 3
+float: 3
+
+Function: Real part of "ccosh_upward":
+double: 1
+float: 2
+
+Function: Imaginary part of "ccosh_upward":
+double: 2
+float: 2
+
+Function: Real part of "cexp":
+double: 2
+float: 1
+
+Function: Imaginary part of "cexp":
+double: 1
+float: 2
+
+Function: Real part of "cexp_downward":
+double: 4
+float: 2
+
+Function: Imaginary part of "cexp_downward":
+double: 3
+float: 3
+
+Function: Real part of "cexp_towardzero":
+double: 4
+float: 2
+
+Function: Imaginary part of "cexp_towardzero":
+double: 3
+float: 3
+
+Function: Real part of "cexp_upward":
+double: 2
+float: 2
+
+Function: Imaginary part of "cexp_upward":
+double: 3
+float: 2
+
+Function: Real part of "clog":
+double: 3
+float: 3
+
+Function: Imaginary part of "clog":
+double: 1
+float: 1
+
+Function: Real part of "clog10":
+double: 3
+float: 4
+
+Function: Imaginary part of "clog10":
+double: 2
+float: 2
+
+Function: Real part of "clog10_downward":
+double: 7
+float: 5
+
+Function: Imaginary part of "clog10_downward":
+double: 8
+float: 4
+
+Function: Real part of "clog10_towardzero":
+double: 5
+float: 5
+
+Function: Imaginary part of "clog10_towardzero":
+double: 8
+float: 4
+
+Function: Real part of "clog10_upward":
+double: 6
+float: 5
+
+Function: Imaginary part of "clog10_upward":
+double: 5
+float: 4
+
+Function: Real part of "clog_downward":
+double: 4
+float: 3
+
+Function: Imaginary part of "clog_downward":
+double: 5
+float: 2
+
+Function: Real part of "clog_towardzero":
+double: 8
+float: 4
+
+Function: Imaginary part of "clog_towardzero":
+double: 5
+float: 3
+
+Function: Real part of "clog_upward":
+double: 8
+float: 3
+
+Function: Imaginary part of "clog_upward":
+double: 8
+float: 2
+
+Function: "cos":
+double: 1
+float: 1
+
+Function: "cos_downward":
+double: 1
+float: 1
+
+Function: "cos_towardzero":
+double: 4
+float: 1
+
+Function: "cos_upward":
+double: 4
+float: 1
+
+Function: "cosh":
+double: 2
+float: 2
+
+Function: "cosh_downward":
+double: 2
+float: 1
+
+Function: "cosh_towardzero":
+double: 2
+float: 1
+
+Function: "cosh_upward":
+double: 2
+float: 2
+
+Function: Real part of "cpow":
+double: 2
+float: 5
+
+Function: Imaginary part of "cpow":
+float: 2
+
+Function: Real part of "cpow_downward":
+double: 5
+float: 8
+
+Function: Imaginary part of "cpow_downward":
+double: 2
+float: 2
+
+Function: Real part of "cpow_towardzero":
+double: 5
+float: 8
+
+Function: Imaginary part of "cpow_towardzero":
+double: 2
+float: 2
+
+Function: Real part of "cpow_upward":
+double: 4
+float: 1
+
+Function: Imaginary part of "cpow_upward":
+double: 2
+float: 2
+
+Function: Real part of "csin":
+double: 1
+float: 1
+
+Function: Real part of "csin_downward":
+double: 3
+float: 3
+
+Function: Imaginary part of "csin_downward":
+double: 3
+float: 1
+
+Function: Real part of "csin_towardzero":
+double: 3
+float: 3
+
+Function: Imaginary part of "csin_towardzero":
+double: 3
+float: 1
+
+Function: Real part of "csin_upward":
+double: 2
+float: 2
+
+Function: Imaginary part of "csin_upward":
+double: 1
+float: 2
+
+Function: Real part of "csinh":
+float: 1
+
+Function: Imaginary part of "csinh":
+double: 1
+float: 1
+
+Function: Real part of "csinh_downward":
+double: 3
+float: 1
+
+Function: Imaginary part of "csinh_downward":
+double: 3
+float: 3
+
+Function: Real part of "csinh_towardzero":
+double: 3
+float: 2
+
+Function: Imaginary part of "csinh_towardzero":
+double: 3
+float: 3
+
+Function: Real part of "csinh_upward":
+double: 1
+float: 2
+
+Function: Imaginary part of "csinh_upward":
+double: 2
+float: 2
+
+Function: Real part of "csqrt":
+double: 2
+float: 2
+
+Function: Imaginary part of "csqrt":
+double: 2
+float: 2
+
+Function: Real part of "csqrt_downward":
+double: 5
+float: 4
+
+Function: Imaginary part of "csqrt_downward":
+double: 4
+float: 3
+
+Function: Real part of "csqrt_towardzero":
+double: 4
+float: 3
+
+Function: Imaginary part of "csqrt_towardzero":
+double: 4
+float: 3
+
+Function: Real part of "csqrt_upward":
+double: 5
+float: 4
+
+Function: Imaginary part of "csqrt_upward":
+double: 3
+float: 3
+
+Function: Real part of "ctan":
+double: 1
+float: 1
+
+Function: Imaginary part of "ctan":
+double: 2
+float: 2
+
+Function: Real part of "ctan_downward":
+double: 6
+float: 5
+
+Function: Imaginary part of "ctan_downward":
+double: 3
+float: 2
+
+Function: Real part of "ctan_towardzero":
+double: 5
+float: 3
+
+Function: Imaginary part of "ctan_towardzero":
+double: 3
+float: 2
+
+Function: Real part of "ctan_upward":
+double: 2
+float: 4
+
+Function: Imaginary part of "ctan_upward":
+double: 2
+float: 1
+
+Function: Real part of "ctanh":
+double: 2
+float: 2
+
+Function: Imaginary part of "ctanh":
+double: 2
+float: 2
+
+Function: Real part of "ctanh_downward":
+double: 3
+float: 2
+
+Function: Imaginary part of "ctanh_downward":
+double: 6
+float: 5
+
+Function: Real part of "ctanh_towardzero":
+double: 3
+float: 2
+
+Function: Imaginary part of "ctanh_towardzero":
+double: 5
+float: 3
+
+Function: Real part of "ctanh_upward":
+double: 2
+float: 2
+
+Function: Imaginary part of "ctanh_upward":
+double: 2
+float: 3
+
+Function: "erf":
+double: 1
+float: 1
+
+Function: "erf_downward":
+double: 1
+float: 1
+
+Function: "erf_towardzero":
+double: 1
+float: 1
+
+Function: "erf_upward":
+double: 1
+float: 1
+
+Function: "erfc":
+double: 5
+float: 3
+
+Function: "erfc_downward":
+double: 5
+float: 6
+
+Function: "erfc_towardzero":
+double: 3
+float: 4
+
+Function: "erfc_upward":
+double: 5
+float: 6
+
+Function: "exp":
+double: 1
+float: 1
+
+Function: "exp10":
+double: 2
+float: 1
+
+Function: "exp10_downward":
+double: 3
+
+Function: "exp10_towardzero":
+double: 3
+
+Function: "exp10_upward":
+double: 2
+float: 1
+
+Function: "exp2":
+double: 1
+
+Function: "exp2_downward":
+double: 1
+
+Function: "exp2_towardzero":
+double: 1
+
+Function: "exp2_upward":
+double: 1
+float: 1
+
+Function: "exp_downward":
+double: 1
+float: 1
+
+Function: "exp_towardzero":
+double: 1
+float: 1
+
+Function: "exp_upward":
+double: 1
+float: 1
+
+Function: "expm1":
+double: 1
+float: 1
+
+Function: "expm1_downward":
+double: 1
+float: 1
+
+Function: "expm1_towardzero":
+double: 1
+float: 2
+
+Function: "expm1_upward":
+double: 1
+float: 1
+
+Function: "gamma":
+double: 4
+float: 7
+
+Function: "gamma_downward":
+double: 7
+float: 7
+
+Function: "gamma_towardzero":
+double: 7
+float: 7
+
+Function: "gamma_upward":
+double: 5
+float: 6
+
+Function: "hypot":
+double: 1
+
+Function: "hypot_downward":
+double: 1
+
+Function: "hypot_towardzero":
+double: 1
+
+Function: "hypot_upward":
+double: 1
+
+Function: "j0":
+double: 2
+float: 9
+
+Function: "j0_downward":
+double: 2
+float: 4
+
+Function: "j0_towardzero":
+double: 4
+float: 5
+
+Function: "j0_upward":
+double: 4
+float: 5
+
+Function: "j1":
+double: 4
+float: 9
+
+Function: "j1_downward":
+double: 4
+float: 5
+
+Function: "j1_towardzero":
+double: 4
+float: 2
+
+Function: "j1_upward":
+double: 3
+float: 5
+
+Function: "jn":
+double: 4
+float: 4
+
+Function: "jn_downward":
+double: 7
+float: 9
+
+Function: "jn_towardzero":
+double: 7
+float: 9
+
+Function: "jn_upward":
+double: 7
+float: 9
+
+Function: "lgamma":
+double: 4
+float: 7
+
+Function: "lgamma_downward":
+double: 7
+float: 7
+
+Function: "lgamma_towardzero":
+double: 7
+float: 7
+
+Function: "lgamma_upward":
+double: 5
+float: 6
+
+Function: "log10":
+double: 2
+float: 2
+
+Function: "log10_downward":
+double: 2
+float: 3
+
+Function: "log10_towardzero":
+double: 2
+float: 1
+
+Function: "log10_upward":
+double: 2
+float: 2
+
+Function: "log1p":
+double: 1
+float: 1
+
+Function: "log1p_downward":
+double: 2
+float: 2
+
+Function: "log1p_towardzero":
+double: 2
+float: 2
+
+Function: "log1p_upward":
+double: 2
+float: 2
+
+Function: "log2":
+float: 1
+
+Function: "log2_downward":
+double: 1
+
+Function: "log2_towardzero":
+double: 1
+
+Function: "log2_upward":
+double: 1
+
+Function: "pow":
+double: 1
+
+Function: "pow_downward":
+double: 1
+float: 1
+
+Function: "pow_towardzero":
+double: 1
+float: 1
+
+Function: "pow_upward":
+double: 1
+float: 1
+
+Function: "sin":
+double: 1
+float: 1
+
+Function: "sin_downward":
+double: 4
+float: 1
+
+Function: "sin_towardzero":
+double: 3
+float: 1
+
+Function: "sin_upward":
+double: 7
+float: 1
+
+Function: "sincos":
+double: 1
+
+Function: "sincos_downward":
+double: 1
+float: 1
+
+Function: "sincos_towardzero":
+double: 4
+float: 1
+
+Function: "sincos_upward":
+double: 1
+float: 1
+
+Function: "sinh":
+double: 2
+float: 2
+
+Function: "sinh_downward":
+double: 3
+float: 3
+
+Function: "sinh_towardzero":
+double: 2
+float: 2
+
+Function: "sinh_upward":
+double: 3
+float: 3
+
+Function: "tan":
+float: 1
+
+Function: "tan_downward":
+double: 1
+float: 2
+
+Function: "tan_towardzero":
+double: 1
+float: 1
+
+Function: "tan_upward":
+double: 1
+float: 1
+
+Function: "tanh":
+double: 2
+float: 2
+
+Function: "tanh_downward":
+double: 3
+float: 3
+
+Function: "tanh_towardzero":
+double: 2
+float: 2
+
+Function: "tanh_upward":
+double: 3
+float: 3
+
+Function: "tgamma":
+double: 9
+float: 8
+
+Function: "tgamma_downward":
+double: 9
+float: 9
+
+Function: "tgamma_towardzero":
+double: 9
+float: 8
+
+Function: "tgamma_upward":
+double: 9
+float: 8
+
+Function: "y0":
+double: 3
+float: 9
+
+Function: "y0_downward":
+double: 3
+float: 6
+
+Function: "y0_towardzero":
+double: 3
+float: 3
+
+Function: "y0_upward":
+double: 3
+float: 6
+
+Function: "y1":
+double: 3
+float: 9
+
+Function: "y1_downward":
+double: 6
+float: 7
+
+Function: "y1_towardzero":
+double: 3
+float: 3
+
+Function: "y1_upward":
+double: 7
+float: 5
+
+Function: "yn":
+double: 3
+float: 3
+
+Function: "yn_downward":
+double: 6
+float: 8
+
+Function: "yn_towardzero":
+double: 8
+float: 8
+
+Function: "yn_upward":
+double: 8
+float: 8
+
+# end of automatic generation
diff --git a/sysdeps/or1k/libm-test-ulps-name b/sysdeps/or1k/libm-test-ulps-name
new file mode 100644
index 0000000000..0af6591fd9
--- /dev/null
+++ b/sysdeps/or1k/libm-test-ulps-name
@@ -0,0 +1 @@
+OpenRISC
diff --git a/sysdeps/or1k/nofpu/math-tests-exceptions.h b/sysdeps/or1k/nofpu/math-tests-exceptions.h
new file mode 100644
index 0000000000..bf2d114692
--- /dev/null
+++ b/sysdeps/or1k/nofpu/math-tests-exceptions.h
@@ -0,0 +1,29 @@
+/* Configuration for math tests: support for exceptions.  OpenRISC no-FPU
+   version.
+   Copyright (C) 2022 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#ifndef OR1K_NOFPU_MATH_TESTS_EXCEPTIONS_H
+#define OR1K_NOFPU_MATH_TESTS_EXCEPTIONS_H 1
+
+/* We support setting floating-point exception flags on hard-float
+   targets.  These are not supported on soft-float targets.  */
+#define EXCEPTION_TESTS_float 0
+#define EXCEPTION_TESTS_double        0
+#define EXCEPTION_TESTS_long_double   0
+
+#endif /* math-tests-exceptions.h.  */
diff --git a/sysdeps/or1k/nofpu/math-tests-rounding.h b/sysdeps/or1k/nofpu/math-tests-rounding.h
new file mode 100644
index 0000000000..604a776747
--- /dev/null
+++ b/sysdeps/or1k/nofpu/math-tests-rounding.h
@@ -0,0 +1,28 @@
+/* Configuration for math tests: rounding mode support.  OpenRISC no-FPU
+   version.
+   Copyright (C) 2022 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#ifndef OR1K_NOFPU_MATH_TESTS_ROUNDING_H
+#define OR1K_NOFPU_MATH_TESTS_ROUNDING_H 1
+
+/* On soft-float targets we only support the "to nearest" rounding mode.  */
+#define ROUNDING_TESTS_float(MODE)		((MODE) == FE_TONEAREST)
+#define ROUNDING_TESTS_double(MODE)		((MODE) == FE_TONEAREST)
+#define ROUNDING_TESTS_long_double(MODE)	((MODE) == FE_TONEAREST)
+
+#endif /* math-tests-rounding.h.  */
diff --git a/sysdeps/or1k/sfp-machine.h b/sysdeps/or1k/sfp-machine.h
new file mode 100644
index 0000000000..37f7bff7c1
--- /dev/null
+++ b/sysdeps/or1k/sfp-machine.h
@@ -0,0 +1,93 @@
+/* OpenRISC softfloat definitions.
+   Copyright (C) 2022 Free Software Foundation, Inc.
+
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library.  If not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#define _FP_W_TYPE_SIZE		32
+#define _FP_W_TYPE		unsigned long
+#define _FP_WS_TYPE		signed long
+#define _FP_I_TYPE		long
+
+#define _FP_MUL_MEAT_S(R,X,Y)				\
+  _FP_MUL_MEAT_1_wide(_FP_WFRACBITS_S,R,X,Y,umul_ppmm)
+#define _FP_MUL_MEAT_D(R,X,Y)				\
+  _FP_MUL_MEAT_2_wide(_FP_WFRACBITS_D,R,X,Y,umul_ppmm)
+#define _FP_MUL_MEAT_Q(R,X,Y)				\
+  _FP_MUL_MEAT_4_wide(_FP_WFRACBITS_Q,R,X,Y,umul_ppmm)
+
+#define _FP_MUL_MEAT_DW_S(R,X,Y)				\
+  _FP_MUL_MEAT_DW_1_wide(_FP_WFRACBITS_S,R,X,Y,umul_ppmm)
+#define _FP_MUL_MEAT_DW_D(R,X,Y)				\
+  _FP_MUL_MEAT_DW_2_wide(_FP_WFRACBITS_D,R,X,Y,umul_ppmm)
+#define _FP_MUL_MEAT_DW_Q(R,X,Y)				\
+  _FP_MUL_MEAT_DW_4_wide(_FP_WFRACBITS_Q,R,X,Y,umul_ppmm)
+
+
+#define _FP_DIV_MEAT_S(R,X,Y)	_FP_DIV_MEAT_1_loop(S,R,X,Y)
+#define _FP_DIV_MEAT_D(R,X,Y)	_FP_DIV_MEAT_2_udiv(D,R,X,Y)
+#define _FP_DIV_MEAT_Q(R,X,Y)	_FP_DIV_MEAT_4_udiv(Q,R,X,Y)
+
+#define _FP_NANFRAC_S		((_FP_QNANBIT_S << 1) - 1)
+#define _FP_NANFRAC_D		((_FP_QNANBIT_D << 1) - 1), -1
+#define _FP_NANFRAC_Q		((_FP_QNANBIT_Q << 1) - 1), -1, -1, -1
+#define _FP_NANSIGN_S		0
+#define _FP_NANSIGN_D		0
+#define _FP_NANSIGN_Q		0
+
+#define _FP_KEEPNANFRACP 1
+#define _FP_QNANNEGATEDP 0
+
+/* Someone please check this.  */
+#define _FP_CHOOSENAN(fs, wc, R, X, Y, OP)			\
+  do {								\
+    if ((_FP_FRAC_HIGH_RAW_##fs(X) & _FP_QNANBIT_##fs)		\
+	&& !(_FP_FRAC_HIGH_RAW_##fs(Y) & _FP_QNANBIT_##fs))	\
+      {								\
+	R##_s = Y##_s;						\
+	_FP_FRAC_COPY_##wc(R,Y);				\
+      }								\
+    else							\
+      {								\
+	R##_s = X##_s;						\
+	_FP_FRAC_COPY_##wc(R,X);				\
+      }								\
+    R##_c = FP_CLS_NAN;						\
+  } while (0)
+
+/* Handle getting and setting rounding mode for soft fp operations.  */
+
+#define FP_RND_NEAREST		(0x0 << 1)
+#define FP_RND_ZERO		(0x1 << 1)
+#define FP_RND_PINF		(0x2 << 1)
+#define FP_RND_MINF		(0x3 << 1)
+#define FP_RND_MASK		(0x3 << 1)
+
+#define FP_EX_OVERFLOW		(1 << 3)
+#define FP_EX_UNDERFLOW		(1 << 4)
+#define FP_EX_INEXACT		(1 << 8)
+#define FP_EX_INVALID		(1 << 9)
+#define FP_EX_DIVZERO		(1 << 11)
+#define FP_EX_ALL \
+	(FP_EX_INVALID | FP_EX_DIVZERO | FP_EX_OVERFLOW | FP_EX_UNDERFLOW \
+	 | FP_EX_INEXACT)
+
+#define _FP_DECL_EX \
+  unsigned int _fpcsr __attribute__ ((unused)) = FP_RND_NEAREST
+
+#define FP_ROUNDMODE (_fpcsr & FP_RND_MASK)
+
+#define _FP_TININESS_AFTER_ROUNDING 0
diff --git a/sysdeps/or1k/tininess.h b/sysdeps/or1k/tininess.h
new file mode 100644
index 0000000000..dafbc6cad5
--- /dev/null
+++ b/sysdeps/or1k/tininess.h
@@ -0,0 +1 @@
+#define TININESS_AFTER_ROUNDING	0
-- 
2.31.1

