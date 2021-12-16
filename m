From: Joseph Myers <joseph@codesourcery.com>
Date: Thu, 16 Dec 2021 19:26:11 +0000
Subject: [OpenRISC] [PATCH v3 05/13] or1k: Thread Local Storage support
In-Reply-To: <2e024bfa-b5c2-2444-1b64-ca8f63e932b6@linaro.org>
References: <20211210233456.4146479-1-shorne@gmail.com>
 <20211210233456.4146479-6-shorne@gmail.com>
 <2e024bfa-b5c2-2444-1b64-ca8f63e932b6@linaro.org>
Message-ID: <alpine.DEB.2.22.394.2112161921110.1715763@digraph.polyomino.org.uk>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, 16 Dec 2021, Adhemerval Zanella via Libc-alpha wrote:

> > +/* Default to an executable stack.  PF_X can be overridden if PT_GNU_STACK is
> > +   present, but it is presumed absent.  */
> > +#define DEFAULT_STACK_PERMS (PF_R | PF_W | PF_X)
> 
> Do you really a default stack executable? It is only done for older ABIs 
> and that's why PT_GNU_STACK was created. Newer ports, like arc and csky 
> assumes otherwise.

I think this reflects what the kernel does (the relevant definitions being 
elf_read_implies_exec and VM_STACK_DEFAULT_FLAGS / VM_DATA_DEFAULT_FLAGS, 
none of which are overridden for openrisc, so the default 
VM_DATA_DEFAULT_FLAGS definition of VM_DATA_FLAGS_EXEC applies).

-- 
Joseph S. Myers
joseph at codesourcery.com
