From: Joseph Myers <joseph@codesourcery.com>
Date: Fri, 22 May 2020 22:02:54 +0000
Subject: [OpenRISC] [PATCH 1/1] Initial support for OpenRISC
In-Reply-To: <20200522215953.GC75760@lianli.shorne-pla.net>
References: <20200522113633.209664-1-shorne@gmail.com>
 <20200522113633.209664-2-shorne@gmail.com>
 <87eerc3z7b.fsf@oldenburg2.str.redhat.com>
 <20200522215953.GC75760@lianli.shorne-pla.net>
Message-ID: <alpine.DEB.2.21.2005222201450.10437@digraph.polyomino.org.uk>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sat, 23 May 2020, Stafford Horne via Libc-alpha wrote:

> For binutils and gcc require patches which are mentioned in the cover letter.
> I will document.

In my view the changes need to be upstream before the patch can go into 
glibc.  We want to avoid the mess we had with MicroBlaze where the port 
turned out to depend on GCC patches that hadn't yet been upstreamed.

-- 
Joseph S. Myers
joseph at codesourcery.com
