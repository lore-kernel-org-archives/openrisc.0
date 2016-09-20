From: Stafford Horne <shorne@gmail.com>
Date: Tue, 20 Sep 2016 19:01:58 +0900 (JST)
Subject: [OpenRISC] [PATCH 5/7] openrisc: Support both old (or32) and
 new (or1k) toolchain
In-Reply-To: <436317ac-6898-d9c2-36eb-79a0b3dc333a@roeck-us.net>
References: <1474036985-20981-1-git-send-email-shorne@gmail.com>
 <1474036985-20981-6-git-send-email-shorne@gmail.com>
 <8ef63a71-81ed-2a0c-e204-666f7fba5e4c@roeck-us.net>
 <alpine.LFD.2.20.1609191459410.2354@lianli.shorne-pla.net>
 <94c3ee37-19f7-de94-9b61-bc1c06a84d72@roeck-us.net>
 <alpine.LFD.2.20.1609191807160.2352@lianli.shorne-pla.net>
 <e4b7075b-a1f7-74b1-ca62-4f3d2058fe97@roeck-us.net>
 <alpine.LFD.2.20.1609192247170.2352@lianli.shorne-pla.net>
 <436317ac-6898-d9c2-36eb-79a0b3dc333a@roeck-us.net>
Message-ID: <alpine.LFD.2.20.1609201901450.2352@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org



On Mon, 19 Sep 2016, Guenter Roeck wrote:

> On 09/19/2016 07:04 AM, Stafford Horne wrote:
>> 
>>
>>  On Mon, 19 Sep 2016, Guenter Roeck wrote:
>> 
>> >  On 09/19/2016 02:11 AM, Stafford Horne wrote:
>> > > 
>> > > 
>> > >   On Mon, 19 Sep 2016, Guenter Roeck wrote:
>> > > 
>> > > >   On 09/18/2016 11:02 PM, Stafford Horne wrote:
>> > > > > > > > >    On Sun, 18 Sep 2016, Guenter Roeck wrote:
>> > > > > > > >    Tested-by: Guenter Roeck <linux@roeck-us.net>
>> > > > > > >    If you plan to handle openrisc going forward, it would be 
>> > > > > > >    great > > > >   if you >  could
>> > > > > >    consider updating MAINTAINERS. The web site and git repository 
>> > > > > >    have > > >   been >  unreachable
>> > > > > >    for a long time.
>> > > > > > >    Thank you,
>> > > > >    Updating maintainers was kind of on my plans, but I figured I 
>> > > > >    need to
>> > > > >    prove that I kind of know what I am doing.
>> > > > > > >   The alternative would be to mark it as Orphaned. Which, for 
>> > > > > > >   all >  practical purpose,
>> > > >   would be the correct state right now.
>> > > 
>> > >   +CC The openrisc list
>> > > 
>> > >   Understood, I don't think we would want that to happen.
>> > > 
>> >  Look at the entry today:
>> > 
>> >  OPENRISC ARCHITECTURE
>> >  M:      Jonas Bonn <jonas@southpole.se>
>> >  W:      http://openrisc.net
>> >  S:      Maintained
>> >  T:      git git://openrisc.net/~jonas/linux
>> >  F:      arch/openrisc/
>> > 
>> >  At the very least, W: and T: are incorrect and need to be updated or 
>> >  removed.
>> >  Plus, apparently there is a L:, and "T: 
>> >  https://github.com/openrisc/linux"
>> >  might be appropriate.
>> > 
>>
>>  Thanks,
>>  I am aware of this, we have since setup a new website, mailing list and as
>>  you have found, git repo. Stefan has been nominated as the maintainer by
>>  Jonas on a previous mail thread.
>>
>>  The issue (as we see it) is that neither Stefan or I have signed PGP keys
>>  by anyone in the web of trust.
>>
>>  I sent this patch set with a cover lett trying to explain of the situation
>>  trying to get some help.  Your reponses are very helpful.
>>
>>  Do you think I should just send "git pull" reuqests to Linus with a self
>>  signed pgp key and eplaination to see how it goes?
>> 
>
> Nope, that won't work. Linus will not accept pull requests without signed 
> key,
> or at least I would be very surprised if he does. You'll have to get your key
> signed. I understand that may be tricky, with you being in Japan (if that is
> you ;-), but we can't help it.

Thats as I figured.

It is me and I just missed LinuxCon Japan 2016 as I was out of town. I 
have some contacts I may be able to reach out to though.

-Stafford

>>  FYI
>>  I have a change as following in my backlog, as follows:
>>
>>  ---
>>  @@ -8691,10 +8063,12 @@ F:      drivers/of/overlay.c
>>   F:     drivers/of/resolver.c
>>
>>  OPENRISC ARCHITECTURE
>>  -M:    Jonas Bonn <jonas@southpole.se>
>>  -W:    http://openrisc.net
>>  +M:    Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
>>  +M:    Stafford Horne <shorne@gmail.com>
>>  +W:    http://openrisc.io
>>  +L:    openrisc at lists.librecores.org
>>  +T:    https://github.com/openrisc/linux.git
>>  S:    Maintained
>>  -T:    git git://openrisc.net/~jonas/linux
>>   F:    arch/openrisc/
>>
>>   OPENVSWITCH
>>
>>  --
>> 
>
>

