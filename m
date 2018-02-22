From: Christoph Hellwig <hch@infradead.org>
Date: Thu, 22 Feb 2018 10:04:20 -0800
Subject: [OpenRISC] Removing architectures without upstream gcc support
In-Reply-To: <CAMo8BfLoqat+6CyOM2VV5Wz13NFMj54YisCogiVm95oDwdnTFQ@mail.gmail.com>
References: <CAK8P3a2-6YwRR3j7J78fVHSvDpq8Kf4wRj6d9mnGgAxgkYypxg@mail.gmail.com>
 <20180222160217.GA18243@infradead.org>
 <CAMo8BfLoqat+6CyOM2VV5Wz13NFMj54YisCogiVm95oDwdnTFQ@mail.gmail.com>
Message-ID: <20180222180420.GA17956@infradead.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Feb 22, 2018 at 09:14:11AM -0800, Max Filippov wrote:
> On Thu, Feb 22, 2018 at 8:02 AM, Christoph Hellwig <hch@infradead.org> wrote:
> > I'd love to see dead architecture ports dropped if they really are
> > more or less abandoned.  In addition to your missing gcc port ones
> > above (minus openrisc) it seems like frv and m32r certainly qualify,
> > and xtensa seems to be going that way with the glibc port being dropped
> > now.
> 
> It's not that it's been dropped, there have never been an official glibc
> port for xtensa, but we're working to get one.

Ah sorry - I meant to say tile not xtensa when writing this.
