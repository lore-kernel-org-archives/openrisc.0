From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Date: Thu, 12 Jan 2017 16:52:57 +0100
Subject: [OpenRISC] [PATCH v2 7/7] uapi: export all headers under uapi
	directories
In-Reply-To: <20170109125638.GA15506@infradead.org>
References: <bf83da6b-01ef-bf44-b3e1-ca6fc5636818@6wind.com>
 <1483695839-18660-1-git-send-email-nicolas.dichtel@6wind.com>
 <1483695839-18660-8-git-send-email-nicolas.dichtel@6wind.com>
 <20170109125638.GA15506@infradead.org>
Message-ID: <464a1323-4450-e563-ff59-9e6d57b75959@6wind.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

Le 09/01/2017 à 13:56, Christoph Hellwig a écrit :
> On Fri, Jan 06, 2017 at 10:43:59AM +0100, Nicolas Dichtel wrote:
>> Regularly, when a new header is created in include/uapi/, the developer
>> forgets to add it in the corresponding Kbuild file. This error is usually
>> detected after the release is out.
>>
>> In fact, all headers under uapi directories should be exported, thus it's
>> useless to have an exhaustive list.
>>
>> After this patch, the following files, which were not exported, are now
>> exported (with make headers_install_all):
> 
> ... snip ...
> 
>> linux/genwqe/.install
>> linux/genwqe/..install.cmd
>> linux/cifs/.install
>> linux/cifs/..install.cmd
> 
> I'm pretty sure these should not be exported!
> 
Those files are created in every directory:
$ find usr/include/ -name '\.\.install.cmd' | wc -l
71
$ find usr/include/ -name '\.install' | wc -l
71

See also
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/scripts/Makefile.headersinst#n32


Thank you,
Nicolas
