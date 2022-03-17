#ifndef __PRINT_H
#define __PRINT_H
void ProcessPacket(unsigned char* , int);
void print_ip_header(unsigned char* , int);
void print_tcp_packet(unsigned char* , int);
void print_udp_packet(unsigned char * , int);
void print_icmp_packet(unsigned char* , int);
void PrintData (unsigned char* , int);

void ProcessPacket(unsigned char* buffer, int size);
void print_ip_header(unsigned char* Buffer, int Size);
void print_tcp_packet(unsigned char* Buffer, int Size);
void print_udp_packet(unsigned char *Buffer , int Size);
void print_icmp_packet(unsigned char* Buffer , int Size);
void PrintData (unsigned char* data , int Size);
#endif
