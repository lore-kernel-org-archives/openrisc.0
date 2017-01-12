From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Date: Thu, 12 Jan 2017 17:32:09 +0100
Subject: [OpenRISC] [PATCH v2 7/7] uapi: export all headers under uapi
	directories
In-Reply-To: <alpine.LSU.2.20.1701121727180.19188@erq.vanv.qr>
References: <bf83da6b-01ef-bf44-b3e1-ca6fc5636818@6wind.com>
 <1483695839-18660-1-git-send-email-nicolas.dichtel@6wind.com>
 <1483695839-18660-8-git-send-email-nicolas.dichtel@6wind.com>
 <20170109125638.GA15506@infradead.org>
 <464a1323-4450-e563-ff59-9e6d57b75959@6wind.com>
 <alpine.LSU.2.20.1701121727180.19188@erq.vanv.qr>
Message-ID: <9d68af8a-a609-d7b1-58a9-f1155313b077@6wind.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

Le 12/01/2017 à 17:28, Jan Engelhardt a écrit :
> On Thursday 2017-01-12 16:52, Nicolas Dichtel wrote:
> 
>> Le 09/01/2017 à 13:56, Christoph Hellwig a écrit :
>>> On Fri, Jan 06, 2017 at 10:43:59AM +0100, Nicolas Dichtel wrote:
>>>> Regularly, when a new header is created in include/uapi/, the developer
>>>> forgets to add it in the corresponding Kbuild file. This error is usually
>>>> detected after the release is out.
>>>>
>>>> In fact, all headers under uapi directories should be exported, thus it's
>>>> useless to have an exhaustive list.
>>>>
>>>> After this patch, the following files, which were not exported, are now
>>>> exported (with make headers_install_all):
>>>
>>> ... snip ...
>>>
>>>> linux/genwqe/.install
>>>> linux/genwqe/..install.cmd
>>>> linux/cifs/.install
>>>> linux/cifs/..install.cmd
>>>
>>> I'm pretty sure these should not be exported!
>>>
>> Those files are created in every directory:
>> $ find usr/include/ -name '\.\.install.cmd' | wc -l
>> 71
> 
> That still does not mean they should be exported.
> 
> Anything but headers (and directories as a skeleton structure) is maximally suspicious.
> 
What I was trying to say is that I export those directories like other are.
Removing those files is not related to that series.


Regards,
Nicolas
