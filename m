Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF76F19F101;
	Wed,  4 Jun 2025 09:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749028854; cv=fail; b=dAoJMKLg464jRXFEFCj0qkE0NAtDQM2NET1zW51IArD8G3WiCSmfgd0JIK4J4TX0J90uhCA7Hk1uwcecv/unSaIbmcYsRfp3j1KLOff3yOTl/EX0znENapqAh6LZr5yEaVM+CfjAoG833/2ynBLzgESsIonC4Q7m77QrfRBb/iM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749028854; c=relaxed/simple;
	bh=DbHfcI1eRgLoxp8xk9+XXjwB8uAYe3E7oI9/tmRwUSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N2Psn9yDM72rUr1xLOxlMvVvyOomZy6oeY8xDYNKoChYbS6fyEEaRv+9hwiO1RavGYjX0CHKJpRBCpEHKJskf+CTSK1hZ6KdArxkrTIbao6JQuAyEoviF+Tjovu676cJO7bhMxfyYu5da93Dk0ZhsrQXIAS4hbld7JcLrVSxIBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AphHktA1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZT5f3deD; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AphHktA1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZT5f3deD"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5548fvVE017036;
	Wed, 4 Jun 2025 09:20:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=DbHfcI1eRgLoxp8xk9+XXjwB8uAYe3E7oI9/tmRwUSA=; b=
	AphHktA1hrU8CP2/TX9KZuSbD9GVxtT3mADVvaVUbTbVHVJASk3zghFqeW22FzmM
	UNF7vFEUpt11Yq6lTLjp3hdYanNK5j9pfCkQ/BsooUJlYMky+muzatlz+N78HN1O
	0H5OKFV2DuTbL1erhGUfflGr9ZaKvrJmlrcOlv8+0UuPv2gMPVU2s8GH2fRrfn5i
	RabIN+3bIiy3lWFKCQSfOHd+YSPPZyYU/uHAEY4Mnh7glvpJLLi2wmRbm7KRqYqu
	Jrs1d/22uBUB4fBSUuyrg4SdgM5CR3fhoTsVLfn5ddR40O1Ur55u7FBLkDJYVe9q
	aDTNze08/xBBgkI1tGkVqQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471g8cuj2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Jun 2025 09:20:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5548Fd30016143;
	Wed, 4 Jun 2025 09:20:08 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2057.outbound.protection.outlook.com [40.107.212.57])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46yr7ahd6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Jun 2025 09:20:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KPeP2xAv86acpBSqhYZVDHR85Dekx6sRna310poMCGsz6VBuqgMnQw05EyjISisp8i5JSMLNvxk3HRTzyOC6BiPbMe8vNZLyT4X3z7+gQLyIYLhNvrOG8TUcQdwB5XJv+YcoTjrTPH9dFDsE2ONmkVZM/XuUtJeGqrITSglv6SOsVlhyxJAfhdcCfQGyNYvLWSPcG+if9Kxdus1ZmzKPj5GSXN/bJ/lOmy93oTVoZeU0Scpx6xnPe6U9aOFyg+F+qNWPUociYR9yCuyaf0dUpPNLhfhyWcxIoI1IGzaKC/+2/+syhiUPiT2Et8ALgWPxTQ5V9+Ylm/SQRHhWF2YskA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbHfcI1eRgLoxp8xk9+XXjwB8uAYe3E7oI9/tmRwUSA=;
 b=p9b+OikTGSJC08nVCW5MFn0jDuprS0TCurltEiILb5qaByRiNbXXFv1cEEsaoY9i/IEPxBbjrfQmqTX2imyGWnWEAie9vyRTZHKWBmyVJw8fgUsPqP9j7QBKpppjBEjhywnAUA+v5v3oEcCTE2wgAUOaMq0DMENecCR9f8Hlm/CyVBD8bhBv1WJQ+hAfnNR9qcRZZ/3kKtVqMrKLc7IUJxhIbsLZ62HVt2GUbXAuKcRYyq4fUZ0thATvZgE15yZSQvxqtPAJI9CTCiQ0On4liALmwVttAyFCCuUQWN64UkDhUW8tp6h7AHkc+fre+Ac/tYYJK9vr5Ya/tIEWd4XerA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbHfcI1eRgLoxp8xk9+XXjwB8uAYe3E7oI9/tmRwUSA=;
 b=ZT5f3deDx4Qc/JDeOjzuC2S0uXT0nkxxoOrVnzSvUPijh/UiwvDi3lYDiV9pMkFQvV0rNcG9wGC8flTshz4Dm7RLEXjpg0//uTPY0mibArhr7FlqMDuNbPHxyR4YYSJ394ZLd0ZWwrVxfiY34cvMa/QcN0QHTbwlK7ky81Dn0UA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CY8PR10MB6514.namprd10.prod.outlook.com (2603:10b6:930:5e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.32; Wed, 4 Jun
 2025 09:20:05 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8746.041; Wed, 4 Jun 2025
 09:20:04 +0000
Date: Wed, 4 Jun 2025 10:20:03 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Barry Song <baohua@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>, Jann Horn <jannh@google.com>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-openrisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-mm@kvack.org
Subject: Re: [PATCH RESEND] mm/pagewalk: split walk_page_range_novma() into
 kernel/user parts
Message-ID: <db00bb89-a7f4-4749-be2f-7a98c7636070@lucifer.local>
References: <20250603192213.182931-1-lorenzo.stoakes@oracle.com>
 <51ec4269-b132-4163-9cb5-766042a3769d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <51ec4269-b132-4163-9cb5-766042a3769d@redhat.com>
X-ClientProxiedBy: LO4P123CA0083.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CY8PR10MB6514:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bde6529-5fb5-4ac7-2019-08dda348fdd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?endyVEo2YTBxL3NjWEgxeEEzdFNyV01Da3owQkZqU1pJb2c1UU8rdGgzOUJX?=
 =?utf-8?B?dUNyTGRCa0pRNkRVUWZoaElwQy9KMUVRdm5FQ0tyakpURXRMcEdYSitYTlB6?=
 =?utf-8?B?L2xTVWludXlrakFuRkZRQ2k5VjFrQktLV2Ywb1pxblNMYWp6Rmc2MVAwL2tz?=
 =?utf-8?B?cUlSdmlPSVRRKzE2VTZuTTE1MVQ2dU40YTNNWmduR2RsRzM4NFdXU1BzMDg1?=
 =?utf-8?B?MzZjcElzR25jbG9NOGJsQ21oNEZvMFlqYmM3djl5a0JhNkdkSGhjNDJlZjdC?=
 =?utf-8?B?QjB2dVNzRDBHYzhQMmp6K0ZLUlpRRFRRcnBkYStET2dNMUNxS2VMU1lyblVq?=
 =?utf-8?B?YXcyUEE2WnN5QzRrR0NFVjQ2ZUg1aWdaSEoyZ29NL0taTkFJZktjYUx1OEJa?=
 =?utf-8?B?bm0wTExudEZDNGhSRFVpeVh5VjRxd09aUGYxU3NWcHg0eVA3NGxMNzFHNUVj?=
 =?utf-8?B?cFJicjVTMG95NmFTcGNyU0VPRStQb2kyNitpMFY4MVloTHhmUkRtVDJGZXVi?=
 =?utf-8?B?bEdDNUg0UjdHUXBJaGo2TVdIbzRydTNldktIalJ5T285dEIvMFAxMndFd3Y2?=
 =?utf-8?B?YTNTL2Q0TFp6aE0rN1JRd0hmQUp2RWtBK1FNaXdrQnJRZ0IwMWM1Qk0yM1lE?=
 =?utf-8?B?Ti9FTVJBdVYvcGZ5ZXNsV3JTczNubTJXMDBwRm9rNFp0ZHRVd2tLTGYyK1Zz?=
 =?utf-8?B?ZGQ0eTBBNzEybGVQSi85c0ZBeE45emlOZUFsQXEwL2hzRmo0bHQ2N2twSFIw?=
 =?utf-8?B?MEVjVFpsL3hwRWxCbkZnU2c4RlJHcGlNU0dBSnF4cTNzeTEzVWFhNzJnZ1Zm?=
 =?utf-8?B?MnNOMSs2T1B6NHFZUElTWWJ2WlZlRnc5QTV6NDBGR0FETVdRNWpWVnBLL3o0?=
 =?utf-8?B?YlNmZWwrOW5kSjBXdlQxMVlBd3pyUXNveUFiUXAzdWlIQ0FLZFFDclFiVW00?=
 =?utf-8?B?NWhOM1NUdmpYcWh6dkxpZFl2QUZob01rSU9TNlpjU05WZytjSFdGVXVndFFS?=
 =?utf-8?B?M3pWa2RhaENsSDBLdW1aMjljcjVNZXVzVGJQVmpqdFY0bERSMWV2aHVPcjgw?=
 =?utf-8?B?L0ZhelFjdUd6VVkyKyswcjhNZ05uY0xTRnhYWjNGUlQvakVKSnlLT05Tb1F1?=
 =?utf-8?B?emh3dHVtU1krLytuSFQ2K2pzZHcyVXZ6WGVsbWIwTFp0aHVsQkE4VW5NUzhM?=
 =?utf-8?B?UW5MSGU2YjdveStuOTlKWUcrMU5HQ200aFlpOS82MGV5emdLT3ptWGp5Nk40?=
 =?utf-8?B?bUM3RDRIWUxoK040b1h0b3hJaHVrcWpsSUlRNHRXOUp6WjlLMkFrUFFwUXlz?=
 =?utf-8?B?S3grNkJjcFlRTERURjAzOEtmc1ZaaTlQUTZzSlFyUUw4aVgxMldhRVBYOE1W?=
 =?utf-8?B?Zk4wUUp0ait4YUx3NEFkVW1WQmJSZHJDOEtaQmc1dkp5TUNMMGNBTnorT2Zl?=
 =?utf-8?B?bjNDWlh5SUcvN080UHc0SEs5eEVmRy9icHhkQkZNTmowb2djWTltTDRzemxW?=
 =?utf-8?B?YXNXS29qRmQ0ZytrMzlNemxuVWVCUFNhWjJUWlRRUW0yZTlmS3VERUxPeTVa?=
 =?utf-8?B?UlE4eGZhS2xGOUV6U3U1Y3pvUTg0VzNXcHNWNXZGT0NSM2MxZHFpRHBUQjVh?=
 =?utf-8?B?WFhzUWY4TzRFU1dBV050YVhFUzZQM2hmNm9Va3k4S1d2Rk1YWE1SNXRLQW8x?=
 =?utf-8?B?c0VkN0tmcUNMOFQxbjVLRDNPZnpaSEYxeHdmMnpDU0xHZDdiWmFOY1gyQVBm?=
 =?utf-8?B?QklWWEh3MlRzSDhjbkZNMEw2MzNaREhYZm1hcGgzRkd3eWhFRmRRcUZZS2ti?=
 =?utf-8?B?ZGpUMEhuWXF3NjR6NGp4RU1uT0kyanFnaWFWd3AzYVU0Um9kU3hyaFdqMEN4?=
 =?utf-8?B?Tk9udUMyVmJESXNHWjdPT1h1U3BBV3lxMTFLOXYyOUdvc2k4bk52aTQxbklS?=
 =?utf-8?Q?ZvNLQTHgmgQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3FCR2Y1V1BmZGQ0WHJkZ2ZuQjFKVFBQK205ejM0L3ZldUdqMlRSUEhNSkov?=
 =?utf-8?B?N3hQeElzZGFEOGNyUnN2RnNCa0I0cklJbDNNSXZpNng3aElzT2NRenNUMGhZ?=
 =?utf-8?B?NzMrK0RucW9VSURMbEVzeDl2b0hrc29XeitlSm9sVERtLzBJYUErYzJhZDVo?=
 =?utf-8?B?clkyWjFVb0RhS0dKUEtZSmJVOHJWcnFERDlpS2F2ZTIxY0NEdjRKVmhVVEE5?=
 =?utf-8?B?d0FuYjBIWnE0WDRWVnhNdk1WbWdKdjdSL0c3TkVvR0xXVlFmczQ0V2ZNOWd4?=
 =?utf-8?B?aGtOU0FWeU8yS1dZZHNzbFJQZ0htTDc0V1phblE2alc0VGhXRjFVUnM2dVhq?=
 =?utf-8?B?dXBUcXlUMWc3WGJxSW5lRUE3VlArUEs5djJoYnJnN2kwQzBvVUlnQTYvT25K?=
 =?utf-8?B?NWg3NElPdVYxcU5CTjJsSU5nZ1doTEJib0hJSGhKQlMzR1JzTTZPQkFvelM0?=
 =?utf-8?B?VWRJMVpGNkcyM1MzL295aGJhMjkvUEFQeDhaUTB0VnBpZDFXR2puZ2JNemNF?=
 =?utf-8?B?Rzh2UGZ3Z1JKeS9nK0ZpS2RET21wcW9VNHlZaXNLMDBQVDN2NXJlaUZzNzFX?=
 =?utf-8?B?L2dPNm41dU1vbFRvTG9pYU1qdS9JMU1BeDVhNGkxVUJ0REJ0YmdmRTdxK2dr?=
 =?utf-8?B?Mi9qZHRIdUdVMTVzOHBqaS92NDNMMEJZMmIvMm8xOEhucE5ycGozV2hJZlQx?=
 =?utf-8?B?c1pTaWEvK0xuRzlpQURuZjVoaFJpLzIydzZXaFJLczVlOVV0WUlnN0NNTW5i?=
 =?utf-8?B?bTRCNHlTWFN2UlhaaFJJVll4dVI3UG5hREhOcFBaTEtPVzVBZGVoeFVkZk8r?=
 =?utf-8?B?NktDWVN0ZmkzV2RkTWN5MEpSR3dHcnZFZnBCUHI1RkZwQUVHVnJ0anBhay8r?=
 =?utf-8?B?a05HTmxSWXA5dGNBNXdiZzUzSDM2K2sxeXFDS25NcUhXaFo0TkdaSFNDMFNw?=
 =?utf-8?B?VEZQWHNyaVp1azFZcmhnc05zci8rZFAzdE9paE1nL2VORWxjRXhEQ1AzZzZo?=
 =?utf-8?B?Ris3U3huSG1hWjJOc0Q2dWdSNWQyTGkvamdRN1FidnhBVGFtV3dMMktnRDgz?=
 =?utf-8?B?Z1had3czbVQ4clI4ejUwTytpRE1sYW5XM2xGTGo5cXZac0xFNTVSekltdFdI?=
 =?utf-8?B?Q2NCSExpRTNmbHJPVjc3M1BuSEVnVmlNRUk5YnNrQUE0aGhxNVdVU1FIZlhG?=
 =?utf-8?B?dVM5YzlwTWhpZTRUQ0dKaWNoc0lMZVM0ald4T0JsOGdXRjFsaDd4ak4vRGhG?=
 =?utf-8?B?VnhGMnhJeTRFelNsSmFUb2pSQWJndlRPbmR4aUJqNVdMUldlQ1cwMWFwVDg0?=
 =?utf-8?B?R01na2IrWDYzSDJrbUVWZXBqYXM0WGdFYTNpN3hxdmM5UTIrT2JBdWVPNnQ5?=
 =?utf-8?B?Slhpc1pQczJNclp5SlJWb2lEeFMvcGpSdGpqT044Rjd4UmhBbml4V21aVzYy?=
 =?utf-8?B?UXlsMnNPQ3BBT0czMWJEYkNQSW1pSy93aS9RUSsyN0YzMnE2TVVXSGdTTWov?=
 =?utf-8?B?VUt3Z0wrOHJtdldSVHN4ejZvZGIvelA2TmE0QWsvbC9GdlE1cVdwL0treWts?=
 =?utf-8?B?SDZpT1JiVDA0RktWZjdiSmpUU2pncng0Qnlrb1BMem5oSEx4OUhPN3FEb3Nn?=
 =?utf-8?B?UVR6d0ZYb3JDVm5TQXNFeXFXSkgyYTg1Nm8rY3pNMU1Sdm9XSWFwaVpTRVBH?=
 =?utf-8?B?cTJrY0NNLzVCeXBjMmYxWFVRWFZTcVo4bGRpM3NQMEtFb3Y2WExFMFBvdVdG?=
 =?utf-8?B?Z3E0QWJDL0pSMk1Ma0RDMjFyWG56RDJGL2Y3RmRCK3Y5akdyUjdXZ2RtTU1Q?=
 =?utf-8?B?eTNGU1ZZcmtwdS9tR2ViZVRJZHAvQVFzMk11R3daVjgyWTFWQzZleXo0RWFo?=
 =?utf-8?B?RlRaUWU2MFFhTXF1WUFSenVrL3VGT2U4alVPRkJzUFE0UXQ2dWx6ZStodFUw?=
 =?utf-8?B?N0xTSHhzbEw0YlZSVGV6dFNTc1F1NS9FV2lKNkhMWlhlSmtROFdValZ5c3pv?=
 =?utf-8?B?dlJNWTNaYjcrbDNWQ3NPSTlMdnFyWWcyRk9nWGx3TzZYekVGbkZHNmQ0VjhQ?=
 =?utf-8?B?YW9BN1d6NHpqYTBNWlFCR2JkeGMxTUQvOTZMWmNpS0xsb1h5NnJLMC9FMGxC?=
 =?utf-8?B?ejg2c2JhRHRSZGR5UExVVTh4YnNTWndpaHNEaGlYeGRkTytxZzFSL3JNalZ4?=
 =?utf-8?B?c2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2kDaEXkYYNuWMW+0DYjDxGCjh979XTbuKbaTR0PVvVLi0vTZeoDLd6DN5kPFfDxJmPuWo5ziYtj5AP18WtUHTgOrkGmhx/iOC6+R8fcG2y0Kh/DLXKZZFxQkHJbFopuIA//usg1WjAYdm43lL/Z/KE/i8RNEZzujUvuyOvnRLLW4ZfMgP+qULyOO/uK+gyF7QeOExSkHKkCtOq1Ls1DkgERBcfrjaWbIkih7NtFGzxS6c0eEmzKm1pcB7wwgDQHaFq5vR+buqLz10HvS+JlVqYZIfqY/JZ+byWu8vQ7OIrRqI9vCld1Iziv3D811d8fcA8lsmv//CeQrjwQMxLzteFaXf3ohol0KhAFGs1wyMKrhg2CnE2/dbQ822jY/30jVkDKG+sqAJwiiesbUQil1Ke/fLKXZ1tEYVoOGRTy90iJ4qPqTv0RlK3/tHvT79p+j+Hdss7MpVzWz88ZDyS5fvsODDVTypH+8+sJvvbxJID87BNQXH1JNCr6QA3WHMUhl1igDO08N3UwAvo3LfHa3mYLPj0u1LdTNIE7rnJ3Usy3KitZTXcP/iFh4IF0vbiGErMp8eOOimedCo3n0LCZJhTUnF8sGp1DzhyH+3E+82zA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bde6529-5fb5-4ac7-2019-08dda348fdd5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 09:20:04.8913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pOw9Iy8uVh0RLp3Ztu9zb7Fj7lrnb3m/duJrjyBaqB5us6hpQCFo/EjK3zh49xMIOa3tOys3U7uOelSmqDwpJUE08X+FZ2ZnNFTatUPaR8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6514
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_02,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506040069
X-Proofpoint-GUID: wSsH2IpNOPMau16sCGE5E-Bxc9rzZkgJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDA2OSBTYWx0ZWRfX23xGa2fMqDFY Bc3z4t6ed1FRJ4KqZUmhQAatTF2VBAKqlgczvuKmefDq+xL7QyHRso6D6HVVxU/5SSZo0VC90jl EMZowi+B58+SE+jmlNrK/rebkttrGrqzyntaMELYl/Hknp1gH1qqlyosst/rWkvvWVPP/Bof810
 6ykQ+EyrRCTJ99q+r92JVu1s3wJthCUAsrwcIslahCmOOJe2GMZNHi75nJ3QR4M6hxgDlVzEzMZ gFb4Q0aEK58EJ+XSeFCria5JOo6fMSbm/FeoA/7aeqJcNrFBhMBvbv3Ap/wsE2Znm/zSONYZEhY RMAMBgBEpM+p5ozUPMG0G+k0sDGAYJdWhDRQZDuud3bCtEhakuesCxwEG2pV1L9XIpdBCmXnPV0
 fXG0u5Yv6LedFw8TJGC98RuyMRFccN7EJpeoBRQxMJh/mJ6wqV/Sx9voHJ6PxsmNUFSZyw0s
X-Authority-Analysis: v=2.4 cv=KaTSsRYD c=1 sm=1 tr=0 ts=68400fc8 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=JfrnYn6hAAAA:8 a=CCfztaf_0IYdkkqjBkgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: wSsH2IpNOPMau16sCGE5E-Bxc9rzZkgJ

On Wed, Jun 04, 2025 at 09:39:30AM +0200, David Hildenbrand wrote:
> On 03.06.25 21:22, Lorenzo Stoakes wrote:
> > The walk_page_range_novma() function is rather confusing - it supports two
> > modes, one used often, the other used only for debugging.
> >
> > The first mode is the common case of traversal of kernel page tables, which
> > is what nearly all callers use this for.
>
> ... and what people should be using it for 🙂

:)

Yeah the whole intent of this patch is to detach the 'crazy debug' bit from
the 'used by arches all over the place' stuff.

Being super clear as to what you're doing matters.

>
> >
> > Secondly it provides an unusual debugging interface that allows for the
> > traversal of page tables in a userland range of memory even for that memory
> > which is not described by a VMA.
> >
> > This is highly unusual and it is far from certain that such page tables
> > should even exist, but perhaps this is precisely why it is useful as a
> > debugging mechanism.
> >
> > As a result, this is utilised by ptdump only. Historically, things were
> > reversed - ptdump was the only user, and other parts of the kernel evolved
> > to use the kernel page table walking here.
> >
> > Since we have some complicated and confusing locking rules for the novma
> > case, it makes sense to separate the two usages into their own functions.
> >
> > Doing this also provide self-documentation as to the intent of the caller -
> > are they doing something rather unusual or are they simply doing a standard
> > kernel page table walk?
> >
> > We therefore maintain walk_page_range_novma() for this single usage, and
> > document the function as such.
>
> If we have to keep this dangerous interface, it should probably be
>
> walk_page_range_debug() or walk_page_range_dump()

Ugh it's too early, I thought Mike suggested this :P but he suggested the
mm/internal.h bit.

But anyway I agree with both, will fix in v2.

>
> >
> > Note that ptdump uses the precise same function for kernel walking as a
> > convenience, so we permit this but make it very explicit by having
> > walk_page_range_novma() invoke walk_page_range_kernel() in this case.
> >
> > We introduce walk_page_range_kernel() for the far more common case of
> > kernel page table traversal.
>
> I wonder if we should give it a completely different name scheme to
> highlight that this is something completely different.
>
> walk_kernel_page_table_range()

Yeah, I think this might be a good idea actually. This is doing something
'unusual' unlike all the other walk_kernel_xxx() handlers, so this should
highlight it even more clearly.

Will fixup in v2.

>
> etc.
>
>
> --
> Cheers,
>
> David / dhildenb
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
