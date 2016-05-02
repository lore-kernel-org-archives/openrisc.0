From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 2 May 2016 14:29:04 -0400
Subject: [OpenRISC] [PATCH] cgen: sim: Updates to sim files to match gdb
	types
In-Reply-To: <20160501190301.GC26300@vapier.lan>
References: <1462069082-8756-1-git-send-email-shorne@gmail.com>
 <20160501190301.GC26300@vapier.lan>
Message-ID: <20160502182904.GJ26300@vapier.lan>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 01 May 2016 15:03, Mike Frysinger wrote:
> On 01 May 2016 11:18, Stafford Horne wrote:
> > The types like MACH and MODEL have changes to SIM_MACH and SIM_MODEL
> > make updates to match these changes.  This way people dont have to
> > manually update the generated files in GDB.
> > 
> > I am from openrisc and working on getting the openrisc sim and gdb patches 
> > ready for submitting to upstream. This was required to get the sim build to 
> > work.
> 
> looks fine to me (since i did make those changes in the sim), but i'm not
> a cgen committer.

i talked to Frank and i'll pick this up.

cgen is still using the CVS tree right ?
-mike
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20160502/aafd6253/attachment.sig>
