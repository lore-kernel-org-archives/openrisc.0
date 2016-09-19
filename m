From: Stafford Horne <shorne@gmail.com>
Date: Tue, 20 Sep 2016 00:16:18 +0900 (JST)
Subject: [OpenRISC] [PATCH 5/7] openrisc: Support both old (or32) and
 new (or1k) toolchain
In-Reply-To: <57DFF797.7090400@southpole.se>
References: <1474036985-20981-1-git-send-email-shorne@gmail.com>
 <1474036985-20981-6-git-send-email-shorne@gmail.com>
 <8ef63a71-81ed-2a0c-e204-666f7fba5e4c@roeck-us.net>
 <alpine.LFD.2.20.1609191459410.2354@lianli.shorne-pla.net>
 <94c3ee37-19f7-de94-9b61-bc1c06a84d72@roeck-us.net>
 <alpine.LFD.2.20.1609191807160.2352@lianli.shorne-pla.net>
 <e4b7075b-a1f7-74b1-ca62-4f3d2058fe97@roeck-us.net>
 <alpine.LFD.2.20.1609192247170.2352@lianli.shorne-pla.net>
 <57DFF797.7090400@southpole.se>
Message-ID: <alpine.LFD.2.20.1609192358540.2352@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org



On Mon, 19 Sep 2016, Jonas Bonn wrote:

> On 09/19/2016 04:04 PM, Stafford Horne wrote:
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
>> > > great > > > >    if you > could
>> > > > > >    consider updating MAINTAINERS. The web site and git 
>> > >  repository have > > >   been > unreachable
>> > > > > >    for a long time.
>> > > > > > >    Thank you,
>> > > > >    Updating maintainers was kind of on my plans, but I figured I 
>> > >  need to
>> > > > >    prove that I kind of know what I am doing.
>> > > > > > >   The alternative would be to mark it as Orphaned. Which, for 
>> > > all >   practical purpose,
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
>
> The bigger question I would have at this point is the value of the code 
> remaining upstream...  Five years ago, there was a promise to try to get the 
> toolchain upstream within a year or two; to this day, I don't know that much 
> progress has been made there so this architecture still requires a 
> hodge-podge of tools from various sources to build.
>
> Given the toolchain maintainer's general reluctance to move things upstream, 
> I'd almost be inclined to just remove the OpenRISC arch from the kernel 
> altogether.  Are there any other arch's that can't be built with an upstream 
> GCC at this point?

Hi Jonas,
We have tried to get the toolchain in order in the last year.  The latest 
efforts is headlined by a toolchain build tutorial here:
   http://openrisc.io/newlib/building.html

The main toolchain project
  binutils-gdb - is upstreamed, I have been working on getting more of the
                 but there are many patches sitting in our repo on github
                 I have been working on getting them rebased to 7.11 and
                 upstreamed.
  newlib       - is upstreamed, with my gdb fixes I have also worked on
                 fixing some bugs in the last year.
  gcc          - this is the problem, the gcc code has not been signed over
                 to the fsf by the original authors.  A clean-room rewrite
                 seems to needed last I checked

The projects are all being maintained on the openrisc github page and we 
are trying to keep it going.

The attraction of openrisc, I would say, is that its one of the only fully 
open platforms in the kernel. Its also relatively simple so for hobbyist 
and students who want to have a 32-bit cpu which they can do 'full-stack' 
development on it fits a good nitch.

Keeping it upstream means also this code base is not getting stale. But we 
do need people to look after it and the patches.

-Stafford

>>
>>  -Stafford
>>
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
>
>

