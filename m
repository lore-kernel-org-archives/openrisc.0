From: Simon Marchi <simon.marchi@polymtl.ca>
Date: Mon, 9 Oct 2017 09:33:20 -0400
Subject: [OpenRISC] [PATCH v5 3/6] sim: or1k: add or1k target to sim
In-Reply-To: <20171009130305.GC2958@lianli.shorne-pla.net>
References: <20171005134912.26799-1-shorne@gmail.com>
 <20171005134912.26799-4-shorne@gmail.com>
 <2a5f900c-99e7-cb4b-9211-b9dab8414de5@polymtl.ca>
 <20171009130305.GC2958@lianli.shorne-pla.net>
Message-ID: <7089df6c-1046-1fd9-150d-1492d4734ac6@polymtl.ca>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 2017-10-09 09:03 AM, Stafford Horne wrote:
>> That code looks strange to me.  Enabling byte reordering (SR[LEE]) makes it so that each
>> group of 4 bytes appears swapped in memory?  Is this something a program can turn on/off
>> at any time?  There isn't much detail about that in the spec it seems.
> 
> I have added some more comments to this in the next patch series.  I am not
> to sure as to the 'why' for this functionality.  But I assume its probably
> to interact with hardware like graphics cards which only support
> little-endian addressing.  The SR[LEE] would only be available to change in
> supervisor mode, so not just any program could change it.
> 
> The above code only handles the address translation (note for half-word
> access openrisc requires the address to be half-word aligned).

Ok, thanks for the explanation.

> FYI, also the testsuite patch aas a few long lines like:
> 
> 	/* The sign extension produces unexpected results here.  */
> 	SHOULD_BE_LESS_THAN_UNSIGNED_I 0xFFFFFFFF - 1, 0xFFFF  /* 0xFFFF gets sign-extended to 0xFFFFFFFF.  */
> 	SHOULD_BE_LESS_THAN_UNSIGNED_I 0xFFFF7FFF, 0x8000  /* 0x8000 gets sign-extended to 0xFFFF8000.  */
> 
> I guess it should be like this?  I don't mind the inline comments, but I
> guess convention is convention?
> 
> 	/* 0xFFFF gets sign-extended to 0xFFFFFFFF.  */
> 	SHOULD_BE_LESS_THAN_UNSIGNED_I 0xFFFFFFFF - 1, 0xFFFF
> 	/* 0x8000 gets sign-extended to 0xFFFF8000.  */
> 	SHOULD_BE_LESS_THAN_UNSIGNED_I 0xFFFF7FFF, 0x8000

Personally I prefer with the comment above.

Simon

