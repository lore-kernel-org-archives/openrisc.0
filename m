From: BAndViG <bandvig@mail.ru>
Date: Fri, 22 Dec 2017 19:03:08 +0300
Subject: [OpenRISC] Modified files in fresh cloned openrisc-linux repository
Message-ID: <370D116035D2495D897C5B3B7A9D6A9E@BAndViG>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello all.
I cloned openrisc/linux repository and checked out 'for-next' branch. I 
hadn't made any modification, but 'git status' reports:

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

        modified:   include/uapi/linux/netfilter/xt_CONNMARK.h
        modified:   include/uapi/linux/netfilter/xt_DSCP.h
        modified:   include/uapi/linux/netfilter/xt_MARK.h
        modified:   include/uapi/linux/netfilter/xt_RATEEST.h
        modified:   include/uapi/linux/netfilter/xt_TCPMSS.h
        modified:   include/uapi/linux/netfilter_ipv4/ipt_ECN.h
        modified:   include/uapi/linux/netfilter_ipv4/ipt_TTL.h
        modified:   include/uapi/linux/netfilter_ipv6/ip6t_HL.h
        modified:   net/netfilter/xt_DSCP.c
        modified:   net/netfilter/xt_HL.c
        modified:   net/netfilter/xt_RATEEST.c
        modified:   net/netfilter/xt_TCPMSS.c

As I'm CygWin-x64 user, I suppose that I could have a problem with it. Could 
anybody make fresh clone (under CygWin, Win or Linux, doesn't matter)  to 
check if the problem 'just for me' or 'for all'?
And one more thing. There isn't any problem with master branch.

BR
Andrey 

