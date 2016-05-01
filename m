From: Mike Frysinger <vapier@gentoo.org>
Date: Sun, 1 May 2016 15:03:01 -0400
Subject: [OpenRISC] [PATCH] cgen: sim: Updates to sim files to match gdb
	types
In-Reply-To: <1462069082-8756-1-git-send-email-shorne@gmail.com>
References: <1462069082-8756-1-git-send-email-shorne@gmail.com>
Message-ID: <20160501190301.GC26300@vapier.lan>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 01 May 2016 11:18, Stafford Horne wrote:
> The types like MACH and MODEL have changes to SIM_MACH and SIM_MODEL
> make updates to match these changes.  This way people dont have to
> manually update the generated files in GDB.
> 
> I am from openrisc and working on getting the openrisc sim and gdb patches 
> ready for submitting to upstream. This was required to get the sim build to 
> work.

looks fine to me (since i did make those changes in the sim), but i'm not
a cgen committer.
-mike
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20160501/c3211b25/attachment.sig>
