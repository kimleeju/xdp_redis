
#include "print.h"

#include<stdio.h>	//For standard things
#include<stdlib.h>	//malloc
#include<string.h>	//memset
#include<netinet/ip_icmp.h>	//Provides declarations for icmp header
#include<netinet/udp.h>	//Provides declarations for udp header
#include<netinet/tcp.h>	//Provides declarations for tcp header
#include<netinet/ip.h>	//Provides declarations for ip header
#include<sys/socket.h>
#include<arpa/inet.h>

#if 0
int sock_raw;
int tcp=0,udp=0,icmp=0,others=0,igmp=0,total=0,i,j;
struct sockaddr_in source,dest;


void ProcessPacket(unsigned char* buffer, int size)
{
	//Get the IP Header part of this packet
	struct iphdr *iph = (struct iphdr*)buffer;
	++total;
	switch (iph->protocol) //Check the Protocol and do accordingly...
	{
		case 1:  //ICMP Protocol
			++icmp;
			//PrintIcmpPacket(Buffer,Size);
			break;
		
		case 2:  //IGMP Protocol
			++igmp;
			break;
		
		case 6:  //TCP Protocol
			++tcp;
			print_tcp_packet(buffer , size);
			break;
		
		case 17: //UDP Protocol
			++udp;
			print_udp_packet(buffer , size);
			break;
		
		default: //Some Other Protocol like ARP etc.
			++others;
			break;
	}
	printf("TCP : %d   UDP : %d   ICMP : %d   IGMP : %d   Others : %d   Total : %d\r",tcp,udp,icmp,igmp,others,total);
}

void print_ip_header(unsigned char* Buffer, int Size)
{
	unsigned short iphdrlen;
		
	struct iphdr *iph = (struct iphdr *)Buffer;
	iphdrlen =iph->ihl*4;
	
	memset(&source, 0, sizeof(source));
	source.sin_addr.s_addr = iph->saddr;
	
	memset(&dest, 0, sizeof(dest));
	dest.sin_addr.s_addr = iph->daddr;
	
	printf("\n");
	printf("IP Header\n");
	printf("   |-IP Version        : %d\n",(unsigned int)iph->version);
	printf("   |-IP Header Length  : %d DWORDS or %d Bytes\n",(unsigned int)iph->ihl,((unsigned int)(iph->ihl))*4);
	printf("   |-Type Of Service   : %d\n",(unsigned int)iph->tos);
	printf("   |-IP Total Length   : %d  Bytes(Size of Packet)\n",ntohs(iph->tot_len));
	printf("   |-Identification    : %d\n",ntohs(iph->id));
	//printf("   |-Reserved ZERO Field   : %d\n",(unsigned int)iphdr->ip_reserved_zero);
	//printf("   |-Dont Fragment Field   : %d\n",(unsigned int)iphdr->ip_dont_fragment);
	//printf("   |-More Fragment Field   : %d\n",(unsigned int)iphdr->ip_more_fragment);
	printf("   |-TTL      : %d\n",(unsigned int)iph->ttl);
	printf("   |-Protocol : %d\n",(unsigned int)iph->protocol);
	printf("   |-Checksum : %d\n",ntohs(iph->check));
	printf("   |-Source IP        : %s\n",inet_ntoa(source.sin_addr));
	printf("   |-Destination IP   : %s\n",inet_ntoa(dest.sin_addr));
}

void print_tcp_packet(unsigned char* Buffer, int Size)
{
	unsigned short iphdrlen;
	
	struct iphdr *iph = (struct iphdr *)Buffer;
	iphdrlen = iph->ihl*4;
	
	struct tcphdr *tcph=(struct tcphdr*)(Buffer + iphdrlen);
			
	printf("\n\n***********************TCP Packet*************************\n");	
		
	print_ip_header(Buffer,Size);
		
	printf("\n");
	printf("TCP Header\n");
	printf("   |-Source Port      : %u\n",ntohs(tcph->source));
	printf("   |-Destination Port : %u\n",ntohs(tcph->dest));
	printf("   |-Sequence Number    : %u\n",ntohl(tcph->seq));
	printf("   |-Acknowledge Number : %u\n",ntohl(tcph->ack_seq));
	printf("   |-Header Length      : %d DWORDS or %d BYTES\n" ,(unsigned int)tcph->doff,(unsigned int)tcph->doff*4);
	//printf("   |-CWR Flag : %d\n",(unsigned int)tcph->cwr);
	//printf("   |-ECN Flag : %d\n",(unsigned int)tcph->ece);
	printf("   |-Urgent Flag          : %d\n",(unsigned int)tcph->urg);
	printf("   |-Acknowledgement Flag : %d\n",(unsigned int)tcph->ack);
	printf("   |-Push Flag            : %d\n",(unsigned int)tcph->psh);
	printf("   |-Reset Flag           : %d\n",(unsigned int)tcph->rst);
	printf("   |-Synchronise Flag     : %d\n",(unsigned int)tcph->syn);
	printf("   |-Finish Flag          : %d\n",(unsigned int)tcph->fin);
	printf("   |-Window         : %d\n",ntohs(tcph->window));
	printf("   |-Checksum       : %d\n",ntohs(tcph->check));
	printf("   |-Urgent Pointer : %d\n",tcph->urg_ptr);
	printf("\n");
	printf("                        DATA Dump                         ");
	printf("\n");
		
	printf("IP Header\n");
	PrintData(Buffer,iphdrlen);
		
	printf("TCP Header\n");
	PrintData(Buffer+iphdrlen,tcph->doff*4);
		
	printf("Data Payload\n");	
	PrintData(Buffer + iphdrlen + tcph->doff*4 , (Size - tcph->doff*4-iph->ihl*4) );
						
	printf("\n###########################################################");
}

void print_udp_packet(unsigned char *Buffer , int Size)
{
	
	unsigned short iphdrlen;
	
	struct iphdr *iph = (struct iphdr *)Buffer;
	iphdrlen = iph->ihl*4;
	
	struct udphdr *udph = (struct udphdr*)(Buffer + iphdrlen);
	
	printf("\n\n***********************UDP Packet*************************\n");
	
	print_ip_header(Buffer,Size);			
	
	printf("\nUDP Header\n");
	printf("   |-Source Port      : %d\n" , ntohs(udph->source));
	printf("   |-Destination Port : %d\n" , ntohs(udph->dest));
	printf("   |-UDP Length       : %d\n" , ntohs(udph->len));
	printf("   |-UDP Checksum     : %d\n" , ntohs(udph->check));
	
	printf("\n");
	printf("IP Header\n");
	PrintData(Buffer , iphdrlen);
		
	printf("UDP Header\n");
	PrintData(Buffer+iphdrlen , sizeof udph);
		
	printf("Data Payload\n");	
	PrintData(Buffer + iphdrlen + sizeof udph ,( Size - sizeof udph - iph->ihl * 4 ));
	
	printf("\n###########################################################");
}

void print_icmp_packet(unsigned char* Buffer , int Size)
{
	unsigned short iphdrlen;
	
	struct iphdr *iph = (struct iphdr *)Buffer;
	iphdrlen = iph->ihl*4;
	
	struct icmphdr *icmph = (struct icmphdr *)(Buffer + iphdrlen);
			
	printf("\n\n***********************ICMP Packet*************************\n");	
	
	print_ip_header(Buffer , Size);
			
	printf("\n");
		
	printf("ICMP Header\n");
	printf("   |-Type : %d",(unsigned int)(icmph->type));
			
	if((unsigned int)(icmph->type) == 11) 
		printf("  (TTL Expired)\n");
	else if((unsigned int)(icmph->type) == ICMP_ECHOREPLY) 
		printf("  (ICMP Echo Reply)\n");
	printf("   |-Code : %d\n",(unsigned int)(icmph->code));
	printf("   |-Checksum : %d\n",ntohs(icmph->checksum));
	//printf("   |-ID       : %d\n",ntohs(icmph->id));
	//printf("   |-Sequence : %d\n",ntohs(icmph->sequence));
	printf("\n");

	printf("IP Header\n");
	PrintData(Buffer,iphdrlen);
		
	printf("UDP Header\n");
	PrintData(Buffer + iphdrlen , sizeof icmph);
		
	printf("Data Payload\n");	
	PrintData(Buffer + iphdrlen + sizeof icmph , (Size - sizeof icmph - iph->ihl * 4));
	
	printf("\n###########################################################");
}

#endif
void PrintData (unsigned char* data , int Size)
{
	int i, j;
	for(i=0 ; i < Size ; i++)
	{
		if( i!=0 && i%16==0)   //if one line of hex printing is complete...
		{
			printf("         ");
			for(j=i-16 ; j<i ; j++)
			{
				if(data[j]>=32 && data[j]<=128)
					printf("%c",(unsigned char)data[j]); //if its a number or alphabet
				
				else printf("."); //otherwise print a dot
			}
			printf("\n");
		} 
		
		if(i%16==0) printf("   ");
			printf(" %02X",(unsigned int)data[i]);
				
		if( i==Size-1)  //print the last spaces
		{
			for(j=0;j<15-i%16;j++) printf("   "); //extra spaces
			
			printf("         ");
			
			for(j=i-i%16 ; j<=i ; j++)
			{
				if(data[j]>=32 && data[j]<=128) printf("%c",(unsigned char)data[j]);
				else printf(".");
			}
			printf("\n");
		}
	}
}
