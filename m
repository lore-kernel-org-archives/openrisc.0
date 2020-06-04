From: Qian Cai <cai@lca.pw>
Date: Thu, 4 Jun 2020 05:50:23 -0400
Subject: [OpenRISC] [PATCH v4 08/14] powerpc: add support for folded p4d
 page tables
In-Reply-To: <20200603120522.7646d56a23088416a7d3fc1a@linux-foundation.org>
References: <20200603120522.7646d56a23088416a7d3fc1a@linux-foundation.org>
Message-ID: <F85B8F19-D717-411A-AFA8-466A02159F27@lca.pw>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org



> On Jun 3, 2020, at 3:05 PM, Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> A bunch of new material just landed in linux-next/powerpc.
> 
> The timing is awkward!  I trust this will be going into mainline during
> this merge window?  If not, please drop it and repull after -rc1.

I have noticed the same pattern over and over again, i.e., many powerpc new material has only shown up in linux-next for only a few days before sending for a pull request to Linus.

There are absolutely no safe net for this kind of practice. The main problem is that Linus seems totally fine with it.
