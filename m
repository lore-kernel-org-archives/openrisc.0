From: Stafford Horne <shorne@gmail.com>
Date: Tue, 5 Sep 2017 06:05:15 +0900
Subject: [OpenRISC] [PATCH v4 2/5] sim: cgen: add MUL2OFSI and MUL1OFSI
 macros (needed for OR1K l.mul[u])
In-Reply-To: <928e7c188eeeff635bc129ba7042d21b@polymtl.ca>
References: <cover.1496066478.git.shorne@gmail.com>
 <700407e5797b8b9b9f76b2dba026d1b06978987b.1496066478.git.shorne@gmail.com>
 <928e7c188eeeff635bc129ba7042d21b@polymtl.ca>
Message-ID: <CAAfxs77UE-pCdTweTAuwBLCpRx+wqopSsJEBs-6cu_4Po45UJw@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Sep 5, 2017 at 5:32 AM, Simon Marchi <simon.marchi@polymtl.ca> wrote:
>> --- a/sim/common/cgen-ops.h
>> +++ b/sim/common/cgen-ops.h
>> @@ -631,6 +631,22 @@ SUBOFQI (QI a, QI b, BI c)
>>    return res;
>>  }
>>
>> +SEMOPS_INLINE BI
>> +MUL2OFSI (SI a, SI b)
>> +{
>> +  DI tmp = MULDI (EXTSIDI(a), EXTSIDI(b));
>> +  BI res = tmp < -0x80000000LL || tmp > 0x7fffffffLL;
>> +  return res;
>> +}
>> +
>> +SEMOPS_INLINE BI
>> +MUL1OFSI (USI a, USI b)
>> +{
>> +  UDI tmp = MULDI (ZEXTSIDI(a), ZEXTSIDI(b));
>> +  BI res = (tmp > 0xFFFFFFFFULL);
>> +  return res;
>> +}
>
>
> What are these functions expected to return?  They seem to return 1 when the
> result would overflow 32-bits, but just to be sure.

They do just return 1 when there is overflow.

They are used in:
    cpu/or1korbis.cpu

To calculate the overflow and carry flags.

   ; 2's complement overflow
   (set sys-sr-ov (mul-o2flag WI rA (ext WI simm16)))
   ; 1's complement overflow
   (set sys-sr-cy (mul-o1flag UWI rA (ext UWI simm16)))

Thanks for pointing this out though the ChangeLog says "New macro, 1's
complement."  I think it should mention "New macro, 1's complement
_overflow_."
