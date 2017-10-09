From: Doug Evans <dje@google.com>
Date: Mon, 09 Oct 2017 17:00:40 +0000
Subject: [OpenRISC] [PATCH v5 1/6] sim: cgen: add remainder functions
 (needed for OR1K lf.rem.[sd])
Message-ID: <94eb2c0628d464df77055b202198@google.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Stafford Horne writes:
 > > > +    else if (n.class == sim_fpu_class_number
 > > > +	&& n.normal_exp <= (NR_FRAC_GUARD)) /* If not too large round.  */
 > > 
 > > This line should be aligned with the opening parenthesis (well, one char to the right).
 > 
 > Right, that does move the comment out of the 80 char range, but just the
 > ending '*/'.  I hope thats ok.

A common thing to do is put the comment on the preceding line.

E.g.,

    else if (n.class == sim_fpu_class_number
             /* If not too large round.  */
             && n.normal_exp <= (NR_FRAC_GUARD))

[appropriately tabbed of course]
