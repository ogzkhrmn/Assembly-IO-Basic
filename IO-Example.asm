                 data segment
prompt  db  "Enter your string(256 Chars Max): $"
nam     db  256 dup(?) ; 7 plus term char $     
newline db  0dh,0ah,"$"
msg1    db  "Your input: $"
sev     db 256 dup(?)
data ends
code segment
assume cs:code,ds:data
START:
mov ax,data
mov ds,ax
mov dx,offset prompt ;write to screen to promp      
mov ah,09h           ;write screen
int 21h              ;
mov cx,256
xor si,si             ;max loop count
loop1:mov ah,01h      ;for input
int 21h               ;input process
cmp al,0dh            ;is enterbutton
je  enterbutton       ;if enter go enterbutton point
mov sev[si],al        ;add char to array
inc si                ;inc si for adding new char to array
loop loop1
enterbutton:
lea dx, newline       ;writenew line
mov ah,09h            ;
int 21h               ;
mov sev[si],'$'       ;add finish char to input array
mov dx,offset msg1    ;write to inputarray screen
mov ah,09h            ;
int 21h               ;
lea dx,sev            ;set array stating adress
mov ah,09h            ;set output settings
int 21h               ;

xor si,si
mov dx,1;             ;start point for array
don: mov al,sev[si]   ;
cmp al,"$"            ;
je cont               ;find arraylength
inc dx                ;
inc si                ;
jmp don               ;




cont:
mov cx,dx             ;set array length for loop count
dec cx                ;always finding one more so we must dec. 
lea si,sev            ;set array finishing addres              
loop2:                

lea dx, newline       ;
mov ah,09h            ;
int 21h               ;
mov dl,[si]           ; write toone by one
mov ah,02h            ;                
int 21h               ;
inc si                ;
loop loop2            ;

Code ends
end Start