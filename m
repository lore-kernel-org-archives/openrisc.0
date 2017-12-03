From: BAndViG <bandvig@mail.ru>
Date: Sun, 3 Dec 2017 17:37:19 +0300
Subject: [OpenRISC] OR1K muti-core machine specifications
Message-ID: <21EACD1242BF4A2CB29FBDF7DB905144@BAndViG>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello, colleagues.
With the mail I would like to start discussion on potential improvement in 
OR1K specification regarding multi-core machine design.
The background for this could be found in IRC 
http://juliusbaxter.net/openrisc-irc/%23openrisc.2017-12-03.log.html
In fact, OR1K spec (including v.1.2) is very abstract in the field.
Lets start with memory access order definitions. Actual spec declares two 
extra-poles: strong ordering and weakly ordering. It looks like "strong 
ordering" could be implemented only in uniprocessor machine while "weakly 
ordering" is so weakly that ... let me cite Stafford Horne "probably no one 
sane would would to go with a really relaxed model like alpha had". 
Additionally, I'm not sure that "strong/weakly" terminology is good enough 
for description memory consistency models. I think the "strong/weakly" are 
mostly comparative categories. For example, SPARC TSO is "weaker" than 
Sequential Consistency, but "stronger" than SPARC PSO. At last, existing SMP 
implementation is most close to  SPARC TSO.
I also agree with Stefan Wallentowitz that consistency model should be 
simple. My 5 cents here "at least initially".

Well, getting all together.

1) I think regarding OR1K SMP machine specification we should borrow SPARC 
approach and terminology and start with description of Total Store Ordering 
(TSO) machine with possible (some time in future) relaxation to Partial 
Store Ordering (PSO) and even to Relaxed Memory Ordering (RMO). 
"Strong/weakly" categories should be used only for comparison of different 
consistency models.

2) Perhaps it could be useful to include description of several hardware 
variants with proof that the machines meet TSO. Perhaps, proof approach 
could be the one described in 
https://pages.cpsc.ucalgary.ca/~higham/Research/papers/WriteBuffers.pdf
By the way, such proof could be good exercises for students. :)

3) Stafford Horn's request. "one thing I see in other architecture is the 
memory barriers (write barrier, read barrier) which we don't really have ".
I think we should do one of the following:
(3a) prove that on TSO machine barriers could be implemented completely in 
software and no special HW- side support is required
(3b) either proof that even on TSO machine barriers could be correctly 
implemented with HW- support only or some how investigate that HW- side 
support increases performance dramatically (or dramatically decreases 
programming efforts or both) while not much costly. In the case we should 
extend instruction set appropriately.

Well, lets start discussion.

Just now I've got questions about l.msync.
(I) Could it be involved in memory barriers implementation as Stafford 
requested? Or its functionality isn't enough?
(II) OR1K spec stays "The memory sync instruction ensures that all memory 
accesses initiated by a program have been performed before the next 
instruction is executed." Could it be relaxed to "... before a next 
load/store instruction is executed."?

WBR
Andrey 

