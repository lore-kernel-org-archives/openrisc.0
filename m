Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020110.outbound.protection.outlook.com [52.101.191.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B800F15DBA3
	for <linux-openrisc@vger.kernel.org>; Mon,  6 Jan 2025 20:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736195530; cv=fail; b=hPNJ6IuzOB1reABe4EwK19qd2QmrWC0VxOlbmYeqiEk7R/jcvYROQUUGzYKXQrIeN5SkbHWm5SGcNeHbiyAxu1tk31vApxMoW6GjqwBuYmQ2b/r+blKyK5Pr2iu8xvQTiRLGO8vZsBy3UBr9smF4ymm8uuqfo2gdSdVe1CH/wxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736195530; c=relaxed/simple;
	bh=J8YMs8Qli90+H8cZHI1fzdoeCK9pzKeBxhkBzeugukg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=olCsYvq2icICOBU2KrqjbYf6rG15ZobOtJMsqCqXdAUBB3gm+/daJ5TKcizQ4y50tYTpqwnJbXolPfw2lN4xjjSXXSLGUXlNPDPTf9+/PTtGQtcZPAzMmVfh7p6yBQukEdUaEYCBQWmGYUu7+4fN6M5rCvZ6g7IyrigIqBEqavE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=K6HzuxsL; arc=fail smtp.client-ip=52.101.191.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="K6HzuxsL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QjjB5rK0P+rPX8aY2ic5w72v+tFinKzRtN3DJDpkdYaFOvypI1QXMX2Ir5KjT0I+bAbgsSvQ94Zb5lXkwFyrso/4lkPgCvOcmNVpsC92eeZUYTkCJoT1nI4/2fmQkcQ5ULjGGWCx97W7/0NEXdhIDbjDw2yvFN/Q8fFVYYj3gK3oLfzXzZooY0rXBc666H19ocJtD6WoBBGUqYKGw97g8GQT37muThH0Qt/801WK+aLvfZed2P7WQ8UbG2neyXMi9Khfu4LrlO2THwsjmnkNdpGRUnSELCSoc1XL5sl6Ty11sTnjaL3bhjOrv8P0ThRp/zYFHNv5hidq/4mIYOU9jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQDIFwrOYOLvCfkG7Z7at7homwE4RleHp5gjHB7CbhI=;
 b=dgcRj0fQCBhLeJGFUcLLkgWJV1mU3cKltv84UbvRbW/9pb1y7tt1ojzYBW8RszVu1pyhjEapyfQmtfzZybDaoLHX/YP9/oZBLtd9JELaZbVclHA9A0r9J77EMbxsxngdRaGDJzJo9WhyhcK/wdY/7qqvw07jY1Oq3hzRD0Zdj+OOZ7Vu3YnDBCEx04ywyRb1NZc+Zmt3SXgolgDNXGOQMn+yxOCyUjLjoVUxVn18Rjg9NsQeYvDH2HWoj99U1SL7KWvgpbGlP3wK9tIMohaF49PzIzsW8TkW+mMXbQo85CJ+koRntoUH/BAxuPDDSVr8bmNJGn9maZrcTn/7/7LwyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQDIFwrOYOLvCfkG7Z7at7homwE4RleHp5gjHB7CbhI=;
 b=K6HzuxsLP9wdcGL7WwGxA0kf1SWJLTf9/H2GT9NEp87D6TMu38H31wGHM3dR8xoDJPRp7qJbRFYXpQovZ8ctlD+xR009fXZdQVrI7JOmLyK3lUBuyC8awNeLTEukXZEglLpllAG9k5UKIoa8T7yR9YViGRiMinA/Jeeb7GhLwdk8K3NUZmd5oP1+tMHLvKW4+DNeJ88rc29uMpzG2gGjOmJ0Ud1T5GX8DVVbDs1hlsHQx1THSIy3E0xtM/mP4j9Dl6m84JnixxxDSW3jwv/cEsnaEd1zosM45c06pAMTlJkxKyrrBKu+l1MYy8e49h4w8NvSXK1Tddrn4YF96wcQKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:24::5)
 by YT1PPF74CBCBF20.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::54e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 20:32:05 +0000
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::be09:e1b:b343:7f9]) by YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::be09:e1b:b343:7f9%4]) with mapi id 15.20.8314.018; Mon, 6 Jan 2025
 20:32:05 +0000
Message-ID: <85d23e75-91c3-4398-aa83-24674379c967@efficios.com>
Date: Mon, 6 Jan 2025 15:32:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nptl: Add <thread_pointer.h> for or1k
To: Stafford Horne <shorne@gmail.com>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
 GLIBC patches <libc-alpha@sourceware.org>
References: <94aee33f-c9d2-428b-9b03-7e4fb1c97472@efficios.com>
 <Z1g2UxaMlKH5o5nc@antec> <Z1h5hzWpD8Fu77AL@antec>
 <8dcf9b95-b7fb-4b5e-8708-b4428b58ecd1@efficios.com>
 <8afa2c34-9416-412d-9920-ab15b44c6d4b@efficios.com> <Z1rZ6APG2ViLdLmy@antec>
 <e249789e-0cfa-4d66-805b-e3cd1aef957a@efficios.com> <Z11l_-7RV07JRwCo@antec>
 <Z2sXcENuw--JWlx6@antec> <9dfd2255-12fe-48ba-a6cd-43956a08e685@efficios.com>
 <Z3w6iz3oo7JCoU_z@antec>
From: Michael Jeanson <mjeanson@efficios.com>
Content-Language: en-CA
In-Reply-To: <Z3w6iz3oo7JCoU_z@antec>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0156.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::28) To YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:24::5)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB5080:EE_|YT1PPF74CBCBF20:EE_
X-MS-Office365-Filtering-Correlation-Id: a12959b6-d4b7-4596-5592-08dd2e912f29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?allWbllnaUxjMldyOWRFR1ZPTUIrMm9NaHNNK0hrTUxyYWVFMUV1SlZLRkw1?=
 =?utf-8?B?SldpZGhKOGNjSDhkZEwzbE9mOHNWTHFmQmg2YnkwUXZabDg3TWUzdXM2UjJE?=
 =?utf-8?B?WlhnckRzUFBCdTVBSDQ2S3pYTEZlZnljYllRcjIvb2g5OUIzYVhVekQ3Z2h5?=
 =?utf-8?B?QjgzcW5tV1NIUTNBZXhDT2VBVHlCNmNkR0lmUytMaHk0YzRpUENER1FGMWE1?=
 =?utf-8?B?TWxHSktqam13OE5aWXg4amcyREdqdGNLZSthenFmWSs0WnR3MzdraXdrM0du?=
 =?utf-8?B?U0VRS3EzYmJuNndoTnhLREFvTW9XZElxTTRtdGJVb01PQmdlZ2JNVjB2U1Zj?=
 =?utf-8?B?MVpUNFBlcUhMRGVBZjlha0hJcW41TGFMNDdYMEFBTVoySlE2Rm9qdndGb3BM?=
 =?utf-8?B?djZvSkZxaStERDh1Yi8rRGRJa2ZubmYvd0pPMmdta0h4RUw3aStSbmpZTnpU?=
 =?utf-8?B?RzJ1ODQyRXYwUHdtWGt2ckY3K1R4bHBxN3dZWXZHeWczS2JUTmNGN21hbWsz?=
 =?utf-8?B?M01ZTGVBUFh6WDFNQ2V2S0ZnNXo2SVY2OG5lVVdnTlZsL0hmM3lUaWRtalJs?=
 =?utf-8?B?NkdlQUIvRXVLQnZqWWRFdE8wOWFJKy84WWs4ZFFtNk9XUlJPblh0ZEtMT0ts?=
 =?utf-8?B?anE2N3BLWmFJc2NPVlV6bkloZm1qa3hBa3pYdmdFOGhYakxNTVFsYTZ0c0xX?=
 =?utf-8?B?eEpPVlAyRm9kc3hBbElFRldBTWhhODQyeGNQZFEremxSVWFES1o5MGlTN0FI?=
 =?utf-8?B?Yzl2U0dnTGNucERKT010Mis3SEk3ZlMrWGRaemFXT2JrcExKajRxelBlTnFw?=
 =?utf-8?B?MjhBWU52YlM4VFpUY25kemhFalhrSkVRR3FmNjlHczVNL3ZSN1hpVnprb0Z6?=
 =?utf-8?B?TVdzVEc4MXZ6UDR1a2kxaWhmN0Y1dE14VWlWbXdJUzN1czFSaUdZVWduWktj?=
 =?utf-8?B?VHNUTCtDR3pIYy8rbk9EVW9nWUI4OEpYWnBpa09rMStBKzNzMFBLVStTUkoz?=
 =?utf-8?B?UzhIUUZQNU1wRnUvL3hCTk9qcEFqOUNJTSt1bEkyUld3UzBtcllVVkZNYUZP?=
 =?utf-8?B?OENLdk1xbmFiakFsVytJZEJreTVObFJXZnRRNkRNUG8vUnArOUJwVjhuOGhO?=
 =?utf-8?B?MFZkOWx5NG9keUdKb2lzQVV2SDgzcjJLVUxmUkpHMkptTi9yRldNdHJmTCtm?=
 =?utf-8?B?YkV3aGt6WUNGQU9FQ3l2Y0lMTklhcU1OYWJCVDRWcGZEVGh2RlRwMmJsT1Fj?=
 =?utf-8?B?UUc1QUJNeXFWZzlZYzgweklQV0pIbEZ6MzNYWC9mUlE2VkJuYlNtRW9YWHF3?=
 =?utf-8?B?aTczTmNyQUI5cUtIT285TmFqbFFlSnV6SFErVEgzMzJSZVZYcisycTFlVUxs?=
 =?utf-8?B?YXI5QmRMQ1ptQjN4aHNHNzNSS1E3aklDSUMxWkZGT2haRTlZeUVTRWJ0TXhS?=
 =?utf-8?B?NWlFVngvRTVUVXI3djlmUkdaMVU1eXBJN0luNjhjSzJlcFVDczlVRW5LN2Mx?=
 =?utf-8?B?VkVDdlJERFRUbUdvczJJdFVMVndMSjJEdWo5Z0dIdTlMZHRCdkZGTHFCRlRa?=
 =?utf-8?B?bnFaMFFtMzJKT2NFaGFxUzk2bS8zNHFrUmtpTmVIdnBmbFNoWmhmYUFxUHcv?=
 =?utf-8?B?SHRsN3l4bWZ3NWMvcDFxRzVQbUpqKzlRL3gvU0ZQSC9JVG1jYWd2VldsbXlU?=
 =?utf-8?B?TFdMbjYxZ3FySlBwYU45K1hTbUh1K2NNNGlvSEdwS3FMVE1GK2ZZY0ZRS3BX?=
 =?utf-8?B?UGVrTXFmdVZCT09KZUJtY2RyaWtKb0VOQzhPSjVEUFRabG9BOGlpMS94VXM1?=
 =?utf-8?B?b1h1dXZPNm9GUXZpZTZaenFNeUtDT1dRUzNRZGZvekJ1ZVl0V3RRRE1QRzY3?=
 =?utf-8?Q?9B6BJTop9yKNu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0hpZVpTSTkyVU50OW1XSlhTUU9WQjB1L2RtV0FKa3dDOG5SZFdBM25Ua3l2?=
 =?utf-8?B?UkUranFacW13ZGVrY05CcTJyMG5aMkcvSlYwa2NFRjVoOVgyUTVvNyt3aHp5?=
 =?utf-8?B?cjNWYVlOQmtXY2hxL3VSenNJOGhHRno1RCtkTXdoNnNzRzUydnZWeUxySGM0?=
 =?utf-8?B?anJyL0tIZnV3dkJ2Y1YzbzUwUllrOEdPblJNdG83UGZBR0lEZDRKenhXTXR1?=
 =?utf-8?B?ajVSOUZLTVJvZlF0Q3VZVjZGMHJPWUZMZWl5WThiRWt2OXJJaG4wL0ZYZ00w?=
 =?utf-8?B?ZjFENG45VXZTUVNtK3NQS1ZzWnVTVWkxT0xrVEtqdXpaKzRycENiaVkrQ0M3?=
 =?utf-8?B?M2YzZi9JMVFVSFYzNmh3SXVOMmlOb1huV05wYXY2L2R6VmdxTHM4YThjM3Z3?=
 =?utf-8?B?bSs3dmcxSWJoZEdhMFlLYWdsdjFheEVxQklSeW1kMGhTUHhwSThSRHRCQkt0?=
 =?utf-8?B?VldJYlZtS0p3NjhsMUJ3N3lDaWx3ejBDZzR0NGJicGoyM1MvUTVwS2p6dTZ3?=
 =?utf-8?B?VG9wajJSN1Bya1ErWTJrTDNvSnF6cy9IdFRNZlhZOXhwS1MvcjZKeUlXaGQx?=
 =?utf-8?B?NzFWclpwZG40YkdoYU00ZHl4Sk4yNHFUQnYzd21nOVpRR2p6cTNDOWVnSXh5?=
 =?utf-8?B?ZUplRjlqL25Xek5nUkVnRldaa2FUZUtXa081dGRUTXRHOC9VTmJjbTlMWXBF?=
 =?utf-8?B?TTYra3ZkWVZHT25DNllsWnVvN25OektzR0lBUCs1MWRyeHVVd3BpYmR0VnA0?=
 =?utf-8?B?TEhldWNLbCtmSFYyblFrN2hNL0VVNVFMbU1hSmhWdWVWSlp2aWJabkR1RmNX?=
 =?utf-8?B?WHZ3d3A3RjVwZG1ycnFQZTdWSnJUSHJkWHRJN1hRbHFsYTJQZ2FETjZGeW5Z?=
 =?utf-8?B?RTZpN1VkeXhYYUgxU09kUWFyZTZrM3F0emxLRHgyb0J6dEYwTGdVYkhHNEVt?=
 =?utf-8?B?bTQ0Vlh6VnVjdWdLeFhRN0xiMnRPakViWnJzendKSHpXOW02S1UvQ3IxZWo3?=
 =?utf-8?B?UE1TWVFYeEE3VlFaZ0hxdzBCUHVjMXY5d2FSMTByUG1DTnNIODFXQm90dTll?=
 =?utf-8?B?UjhaZGtrRkRFa3F2dm9Hbm04U21YN3NEVVRqcm9sc2hwZFVSOHlrVFFqN0RM?=
 =?utf-8?B?TUpNZ0ttUTVzZ2hlaUFYdWs0S3lLTHppV2g1eVFGU1NuNXNYY1ZMNVp3b2hZ?=
 =?utf-8?B?Z2p4MlNXcjEvZ2psR1R4NnJyU0kzR1VkM2pnU1NYMnJNRHlvdW1vQldJUjJO?=
 =?utf-8?B?d2ZoaSttTDRXV0dremdCN3NjNEk2aEdKeUdWbERxREh0UXdKMEJ2dnFEQTVq?=
 =?utf-8?B?THVFNWhYYUV6RHptVkVJY3AydjFDWWlRTGk4a3Z4WDdYRzV6eVlmWXQyNG12?=
 =?utf-8?B?MnpLeDc2WmhjVkpYQjNlc3AvcDZ1allXK0FBdm9Da3padUFRUzE0YjhZeEtv?=
 =?utf-8?B?ZHUycE54TFdBWjRjSzV3K1UwYklGN2hOcnpUZ2p6Z0grOG5YTzl0TWdka2tX?=
 =?utf-8?B?c1FNdy9kQnU0S2xmNEZJU1RaY3c3dVdJK1EzZnA2OUVmZkk5Nk1aUk9DU1JS?=
 =?utf-8?B?V3BycHFuckZwcFJmeXV3dHJkWnVzQzRmc1RwUHZ1S0I4dVBjeTdzVzNPT21S?=
 =?utf-8?B?SkwxY2dBbEhuTW9lMDg5NnA0Tk9HejJZMnVKQTBmVUtqcXJ6U21aWU5pT0hp?=
 =?utf-8?B?Z2FFNjBITiszVjB6dVJMTktteG13RVZWZ1ZCbldueitOVkhrNUQ2RGQ1UEZP?=
 =?utf-8?B?MFFQdk8waFlaMzFjMG13WTJmOUw4TmZyRnp4cUc1SjdiakJQRXFvbTVoRFU4?=
 =?utf-8?B?cGk4eXc2eEk4YloybU1tT1FacVRiLzZoV3YvRXNIK1E5MUZYRnNRSkZVK2tT?=
 =?utf-8?B?a05ncjVHMjltekFGSlNtOEZiQ0duUVo0SnNQd2x0dnlaY0tJdXNHV2FtSjl5?=
 =?utf-8?B?azhmTG0yVVlGM1FreXpsZllmY1d2cTNMMi9ralpJNm5JSFRXMzFWeWdwWHpu?=
 =?utf-8?B?WXVkMnNBN3NEemVDbzY5NnJwTElpVnE4QllMZ0FQTkt2bCtiRndqWGFZRmFr?=
 =?utf-8?B?VVA4OExlNkF5dU56bVVyRlRHVkNhVkdxNVZNc2JXS2dBc1U3VWFhNGJFUGJk?=
 =?utf-8?B?UHM0U1doaE9DTFB5cVRBT3p4b0FXRW5aNkxqQmF4NVM5STZ5bS8vVHZ4eUxD?=
 =?utf-8?B?Y0E9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a12959b6-d4b7-4596-5592-08dd2e912f29
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 20:32:05.4483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qOR7Rfr2tLDGM6sFJS/sUwapdK1PQzC6IzjwSsWIHqTVxx2aI5xj7IIAEp+RlVH5Aksm4mKWeTbuyK49UECmCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PPF74CBCBF20

On 2025-01-06 15:18, Stafford Horne wrote:
> 
> No problem,
> 
> I figured you were on vacation.  I just kept sending mails to document my
> progress.  The holiday's are when I get the most time to work on this stuff.
> 
> As of now there is nothing else needed.
> 
> -Stafford

Thanks for taking care of this!

Michael
