From: Nick Clifton <nickc@redhat.com>
Date: Thu, 4 Oct 2018 16:32:20 +0100
Subject: [OpenRISC] [PATCH v3 2/5] or1k: Fix messages for relocations in
 shared libraries
In-Reply-To: <20181004032317.17478-3-shorne@gmail.com>
References: <20181004032317.17478-1-shorne@gmail.com>
 <20181004032317.17478-3-shorne@gmail.com>
Message-ID: <74e3309d-7f1c-927a-8a20-1c5c27eea578@redhat.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Stafford,

> bfd/ChangeLog:
> 
> 	* elf32-or1k.c (or1k_elf_relocate_section): Add error for unknown
> 	relocations.  Add error for non zero addend with plt and got
> 	relocations.  Add error for got and plt references against dynamic, non
> 	local, symbols.  Add error when linking non shared liraries with
> 	flag_pic. 

Approved.

