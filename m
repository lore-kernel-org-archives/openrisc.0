From: Stafford Horne <shorne@gmail.com>
Date: Thu, 27 Feb 2020 22:29:08 +0900
Subject: [OpenRISC] [PATCH 2/3] openrisc: Enable the clone3 syscall
In-Reply-To: <20200227122147.rnpzcy7rjexgy6yx@wittgenstein>
References: <20200226225625.28935-1-shorne@gmail.com>
 <20200226225625.28935-3-shorne@gmail.com>
 <20200227122147.rnpzcy7rjexgy6yx@wittgenstein>
Message-ID: <20200227132908.GI7926@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Feb 27, 2020 at 01:21:47PM +0100, Christian Brauner wrote:
> On Thu, Feb 27, 2020 at 07:56:24AM +0900, Stafford Horne wrote:
> > Enable the clone3 syscall for OpenRISC.  We use the generic version.
> > 
> > This was tested with the clone3 test from selftests.  Note, for all
> > tests to pass it required enabling CONFIG_NAMESPACES which is not
> > enabled in the default kernel config.
> 
> For OpenRISC, I assume. Hm, maybe we should fix the tests to skip when
> CONFIG_NAMESPACES is not enabled.

Yes, not the default for openrisc defconfig.  It might make sense to either skip
the tests of have them as expected fails when CONFIG_NAMESPACES is off.

On the otherhand, I am not sure if the self tests know about the CONFIG_*
available.  I notice many test directories have a 'config' file and a readme
saying, for these test to run ensure use have at least 'these' config values
set.

-Stafford
