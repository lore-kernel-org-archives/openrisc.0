From: Christoph Hellwig <hch@infradead.org>
Date: Wed, 5 Dec 2018 06:45:17 -0800
Subject: [OpenRISC] [PATCH 3/3] arch: remove redundant generic-y defines
In-Reply-To: <20181205144438.GA30692@infradead.org>
References: <1544009286-15705-1-git-send-email-yamada.masahiro@socionext.com>
 <1544009286-15705-3-git-send-email-yamada.masahiro@socionext.com>
 <20181205144438.GA30692@infradead.org>
Message-ID: <20181205144517.GB30692@infradead.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Dec 05, 2018 at 06:44:38AM -0800, Christoph Hellwig wrote:
> On Wed, Dec 05, 2018 at 08:28:06PM +0900, Masahiro Yamada wrote:
> > Now that Kbuild automatically creates asm-generic wrappers for missing
> > mandatory headers, it is redundant to list the same headers in
> > generic-y and mandatory-y.
> > 
> > Suggested-by: Sam Ravnborg <sam@ravnborg.org>
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> 
> Oh, that is very useful, especially as maintainance of those
> generic-y lines has been a mess!
> 
> Acked-by: Christoph Hellwig <hch@lst.de>

Actually - it seems like you are keeping some generic-y lines, what
is the reason for that?
