From: Nick Clifton <nickc@redhat.com>
Date: Fri, 23 Aug 2019 10:50:17 +0100
Subject: [OpenRISC] [PATCH] or1k: Fix incorrect value in PLT GOT entries,
 causing infinite loop
In-Reply-To: <20190822112757.32751-1-shorne@gmail.com>
References: <20190822112757.32751-1-shorne@gmail.com>
Message-ID: <9117019e-3b9c-447e-749d-1200d5b61a12@redhat.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Stafford,

> bfd/ChangeLog:
> 
> 	* elf32-or1k.c (or1k_elf_finish_dynamic_symbol): Use correct value for
> 	PLT GOT entries.

Approved - please apply.

Cheers
  Nick
