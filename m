From: Stafford Horne <shorne@gmail.com>
Date: Sat, 26 Nov 2016 07:50:41 +0900 (JST)
Subject: [OpenRISC] [PATCH 00/18] gdb: Port for OpenRISC
In-Reply-To: <20161124203629.gaokqfocdcev2zfq@localhost>
References: <1479939044-1341-1-git-send-email-shorne@gmail.com>
 <20161124203629.gaokqfocdcev2zfq@localhost>
Message-ID: <alpine.LFD.2.20.1611260747470.29569@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org



On Thu, 24 Nov 2016, Yao Qi wrote:

> On Thu, Nov 24, 2016 at 07:10:26AM +0900, Stafford Horne wrote:
>> Hello,
>>
>> This is the openrisc port of GDB that has been in openrisc
>> repositories for a very long time. The main original author
>> was Jeremy Bennett as can be seen in file copyrights. Other
>> are willing to do what it takes for FSF copyright assignment.
>>
>
> Hi Stafford,
> It is a new port in FSF GDB, and we want the quality of this new port is
> good enough, so the history of openrisc branch isn't very important in
> the patch review.  Please put all or1k-tdep.{c,h} changes into a single
> patch, and the authors in the ChangeLog entry should be all the
> contributors to or1k-tdep.{c,h}.  The target independent changes can
> still sit in each patch if necessary.

Thanks I am working on this. Getting the changelog fixed up is taking time 
as not all authors over the years maintained this so well.

> Please look at https://sourceware.org/gdb/wiki/ContributionChecklist

Thanks this is helpful.

-Stafford

