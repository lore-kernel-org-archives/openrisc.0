From: Adhemerval Zanella <adhemerval.zanella@linaro.org>
Date: Tue, 14 Dec 2021 22:15:04 -0300
Subject: [OpenRISC] [PATCH v3 03/13] or1k: ABI Implementation
In-Reply-To: <alpine.DEB.2.22.394.2112142242120.1558178@digraph.polyomino.org.uk>
References: <20211210233456.4146479-1-shorne@gmail.com>
 <20211210233456.4146479-4-shorne@gmail.com>
 <a0644ab7-85a5-e22d-607e-4e6761d87610@linaro.org>
 <alpine.DEB.2.22.394.2112142242120.1558178@digraph.polyomino.org.uk>
Message-ID: <86e61afa-ab95-62e1-10a7-3de71db8deb8@linaro.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org



On 14/12/2021 19:43, Joseph Myers wrote:
> On Tue, 14 Dec 2021, Adhemerval Zanella via Libc-alpha wrote:
> 
>> +if test "x$profile" != xno; then
>> +  if test "x$with_profile" == xno; then
>> +    AC_MSG_ERROR([ABI does not support profiling])
> 
> Using == in test is a bashism.
> 
> I'd expect such a change to require the build-many-glibcs.py configuration 
> for OpenRISC to use --disable-profile.
> 

I ended up mixing up things and what or1k does not support is LD_PROFILE
instead of --enable-profile.  In this case I am not sure if it would
be better to just not enable it (by ignoring the LD_PROFILE handling
in rtld.c or dl-support.c) and emitting a warning or by just dumping
and error at process initialization.
