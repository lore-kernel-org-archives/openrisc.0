From: Jonas Bonn <jonas@southpole.se>
Date: Fri, 24 Feb 2017 10:27:37 +0100
Subject: [OpenRISC] [PATCH v4 06/24] openrisc: add l.lwa/l.swa emulation
In-Reply-To: <63104c06a9eddf53f88f6d16196bb036c62967b2.1487910170.git.shorne@gmail.com>
References: <cover.1487910170.git.shorne@gmail.com>
 <63104c06a9eddf53f88f6d16196bb036c62967b2.1487910170.git.shorne@gmail.com>
Message-ID: <24e21370-7705-a1d5-0327-811d6ac81165@southpole.se>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 02/24/2017 05:32 AM, Stafford Horne wrote:
> From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
>
> This adds an emulation layer for implementations
> that lack the l.lwa and l.swa instructions.
> It handles these instructions both in kernel space and
> user space.
>
> Signed-off-by: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> [shorne at gmail.com: Added delay slot pc adjust logic]
> Signed-off-by: Stafford Horne <shorne@gmail.com>
What happened here?  A bit of junk has slunk in among your Sign-offs!

/Jonas

