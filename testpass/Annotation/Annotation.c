// Annotation.c

int a __attribute__((annotate(("hello1")))) = 3;

int b(int __attribute__((annotate(("hello2")))) c)
{
  return c + 41;
}

int d(int e) __attribute__((annotate(("hello")))) __attribute__((annotate(("twice"))))
{
  return e + 42;
}

int e()
{

  if (a)
  {
    int aa __attribute__((annotate(("ha")))) = a;
    if (aa + 1)
    {
      int b __attribute__((annotate(("ha")))) = aa;
      return 3;
    }
  }
  return 0;
}
// Disassembly of section .text:

// 0000000000000000 <b>:
//    0:   55                      push   %rbp
//    1:   48 89 e5                mov    %rsp,%rbp
//    4:   89 7d fc                mov    %edi,-0x4(%rbp)
//    7:   8b 45 fc                mov    -0x4(%rbp),%eax
//    a:   83 c0 29                add    $0x29,%eax
//    d:   5d                      pop    %rbp
//    e:   c3                      retq
//    f:   90                      nop

// 0000000000000010 <d>:
//   10:   55                      push   %rbp
//   11:   48 89 e5                mov    %rsp,%rbp
//   14:   89 7d fc                mov    %edi,-0x4(%rbp)
//   17:   8b 45 fc                mov    -0x4(%rbp),%eax
//   1a:   83 c0 2a                add    $0x2a,%eax
//   1d:   5d                      pop    %rbp
//   1e:   c3                      retq
