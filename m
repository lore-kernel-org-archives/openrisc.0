From: Joseph Myers <joseph@codesourcery.com>
Date: Tue, 14 Dec 2021 22:43:50 +0000
Subject: [OpenRISC] [PATCH v3 03/13] or1k: ABI Implementation
In-Reply-To: <a0644ab7-85a5-e22d-607e-4e6761d87610@linaro.org>
References: <20211210233456.4146479-1-shorne@gmail.com>
 <20211210233456.4146479-4-shorne@gmail.com>
 <a0644ab7-85a5-e22d-607e-4e6761d87610@linaro.org>
Message-ID: <alpine.DEB.2.22.394.2112142242120.1558178@digraph.polyomino.org.uk>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, 14 Dec 2021, Adhemerval Zanella via Libc-alpha wrote:

> +if test "x$profile" != xno; then
> +  if test "x$with_profile" == xno; then
> +    AC_MSG_ERROR([ABI does not support profiling])

Using == in test is a bashism.

I'd expect such a change to require the build-many-glibcs.py configuration 
for OpenRISC to use --disable-profile.

-- 
Joseph S. Myers
joseph at codesourcery.com
