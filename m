From: Arnd Bergmann <arnd@kernel.org>
Date: Wed, 16 Feb 2022 14:07:00 +0100
Subject: [OpenRISC] [PATCH 11/14] sparc64: remove CONFIG_SET_FS support
In-Reply-To: <Ygr4Q2/KxfF86ETa@zeniv-ca.linux.org.uk>
References: <20220214163452.1568807-1-arnd@kernel.org>
 <20220214163452.1568807-12-arnd@kernel.org>
 <Ygr4Q2/KxfF86ETa@zeniv-ca.linux.org.uk>
Message-ID: <CAK8P3a30supB-MNzhoELOerOemxwTfDFFqZrzmNDQA=WW+VLbw@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Feb 15, 2022 at 1:48 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, Feb 14, 2022 at 05:34:49PM +0100, Arnd Bergmann wrote:
>
> > -/*
> > - * Sparc64 is segmented, though more like the M68K than the I386.
> > - * We use the secondary ASI to address user memory, which references a
> > - * completely different VM map, thus there is zero chance of the user
> > - * doing something queer and tricking us into poking kernel memory.
>
> Actually, this part of comment probably ought to stay - it is relevant
> for understanding what's going on (e.g. why is access_ok() always true, etc.)

Ok, I've put it back now.

       Arnd
