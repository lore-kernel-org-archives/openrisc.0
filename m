From: Simon Marchi <simon.marchi@polymtl.ca>
Date: Sun, 08 Oct 2017 10:06:20 -0400
Subject: [OpenRISC] [PATCH v5 1/6] sim: cgen: add remainder functions
 (needed for OR1K lf.rem.[sd])
In-Reply-To: <20171008122357.GA2958@lianli.shorne-pla.net>
References: <20171005134912.26799-1-shorne@gmail.com>
 <20171005134912.26799-2-shorne@gmail.com>
 <22127605-6ea8-05c4-03a6-cc37478bd459@polymtl.ca>
 <20171008122357.GA2958@lianli.shorne-pla.net>
Message-ID: <e757489a1343720d22d2ec33518fac4c@polymtl.ca>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 2017-10-08 08:23, Stafford Horne wrote:
>> > +    if (n.normal_exp < -1) /* If n looks like zero just return l.  */
>> > +      {
>> > +	*f = *l;
>> > +	return 0;
>> > +      }
>> > +    else if (n.class == sim_fpu_class_number
>> > +	&& n.normal_exp <= (NR_FRAC_GUARD)) /* If not too large round.  */
>> 
>> This line should be aligned with the opening parenthesis (well, one 
>> char to the right).
> 
> Right, that does move the comment out of the 80 char range, but just 
> the
> ending '*/'.  I hope thats ok.

Hmm, when I try it the trailing */ arrives right before the 80th column.

Simon
