From: Joseph Myers <joseph@codesourcery.com>
Date: Fri, 22 May 2020 18:52:20 +0000
Subject: [OpenRISC] [PATCH 0/1] OpenRISC port
In-Reply-To: <20200522113633.209664-1-shorne@gmail.com>
References: <20200522113633.209664-1-shorne@gmail.com>
Message-ID: <alpine.DEB.2.21.2005221846590.10437@digraph.polyomino.org.uk>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, 22 May 2020, Stafford Horne via Libc-alpha wrote:

> Hi All,
> 
> This is the patch for the OpenRISC port of glibc.

Please see <https://sourceware.org/glibc/wiki/NewPorts> for information to 
include in a new port submission.  That includes pointing to architecture 
and ABI manuals.

> The original patch was put together by Christian Scensson a few years ago.  I
> have taken the patch and finished all of the TODO items and run and fixed all of
> the test failures.

Do you mean Christian Svensson?  (There's a copyright assignment from 
Christian Svensson for GCC GLIBC BINUTILS from 2014.)

> TEST RESULTS
> 
> Pretty much all tests are passing however there are several math (fpu) tests
> which are failing due to issues with setting underflow/overflow flags.  These

There should not be any such failures with a correct port and architecture 
implementation.

> I can provide more details.

Full test results should be provided (see the above mentioned wiki page).

-- 
Joseph S. Myers
joseph at codesourcery.com
