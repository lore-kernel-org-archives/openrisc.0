From: Yao Qi <qiyaoltc@gmail.com>
Date: Thu, 24 Nov 2016 20:36:29 +0000
Subject: [OpenRISC] [PATCH 00/18] gdb: Port for OpenRISC
In-Reply-To: <1479939044-1341-1-git-send-email-shorne@gmail.com>
References: <1479939044-1341-1-git-send-email-shorne@gmail.com>
Message-ID: <20161124203629.gaokqfocdcev2zfq@localhost>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Nov 24, 2016 at 07:10:26AM +0900, Stafford Horne wrote:
> Hello,
> 
> This is the openrisc port of GDB that has been in openrisc
> repositories for a very long time. The main original author
> was Jeremy Bennett as can be seen in file copyrights. Other
> are willing to do what it takes for FSF copyright assignment.
> 

Hi Stafford,
It is a new port in FSF GDB, and we want the quality of this new port is
good enough, so the history of openrisc branch isn't very important in
the patch review.  Please put all or1k-tdep.{c,h} changes into a single
patch, and the authors in the ChangeLog entry should be all the
contributors to or1k-tdep.{c,h}.  The target independent changes can
still sit in each patch if necessary.

Please look at https://sourceware.org/gdb/wiki/ContributionChecklist

-- 
Yao 

