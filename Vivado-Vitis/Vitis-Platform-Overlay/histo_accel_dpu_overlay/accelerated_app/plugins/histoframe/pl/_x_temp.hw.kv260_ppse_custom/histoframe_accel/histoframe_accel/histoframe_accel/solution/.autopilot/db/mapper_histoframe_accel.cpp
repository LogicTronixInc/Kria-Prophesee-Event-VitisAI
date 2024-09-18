#include <algorithm>
#include <cassert>
#include <fstream>
#include <iostream>
#include <list>
#include <map>
#include <vector>
#include "ap_fixed.h"
#include "ap_int.h"
#include "hls_stream.h"
using namespace std;

namespace hls::sim
{
  template<size_t n>
  struct Byte {
    unsigned char a[n];

    Byte()
    {
      for (size_t i = 0; i < n; ++i) {
        a[i] = 0;
      }
    }

    template<typename T>
    Byte<n>& operator= (const T &val)
    {
      std::memcpy(a, &val, n);
      return *this;
    }
  };

  struct SimException : public std::exception {
    const char *msg;
    const size_t line;
    SimException(const char *msg, const size_t line)
      : msg(msg), line(line)
    {
    }
  };

  void errExit(const size_t line, const char *msg)
  {
    std::string s;
    s += "at line ";
    s += std::to_string(line);
    s += " occurred problem: ";
    s += msg;
    s += "\n";
    fputs(s.c_str(), stderr);
    exit(1);
  }
}


namespace hls::sim
{
  struct Buffer {
    char *first;
    Buffer(char *addr) : first(addr)
    {
    }
  };

  struct DBuffer : public Buffer {
    static const size_t total = 1<<10;
    size_t ufree;

    DBuffer(size_t usize) : Buffer(nullptr), ufree(total)
    {
      first = new char[usize*ufree];
    }

    ~DBuffer()
    {
      delete[] first;
    }
  };

  struct CStream {
    char *front;
    char *back;
    size_t num;
    size_t usize;
    std::list<Buffer*> bufs;
    bool dynamic;

    CStream() : front(nullptr), back(nullptr),
                num(0), usize(0), dynamic(true)
    {
    }

    ~CStream()
    {
      for (Buffer *p : bufs) {
        delete p;
      }
    }

    template<typename T>
    T* data()
    {
      return (T*)front;
    }

    template<typename T>
    void transfer(hls::stream<T> *param)
    {
      while (!empty()) {
        param->write(*(T*)nextRead());
      }
    }

    bool empty();
    char* nextRead();
    char* nextWrite();
  };

  bool CStream::empty()
  {
    return num == 0;
  }

  char* CStream::nextRead()
  {
    assert(num > 0);
    char *res = front;
    front += usize;
    if (dynamic) {
      if (++static_cast<DBuffer*>(bufs.front())->ufree == DBuffer::total) {
        if (bufs.size() > 1) {
          bufs.pop_front();
          front = bufs.front()->first;
        } else {
          front = back = bufs.front()->first;
        }
      }
    }
    --num;
    return res;
  }

  char* CStream::nextWrite()
  {
    if (dynamic) {
      if (static_cast<DBuffer*>(bufs.back())->ufree == 0) {
        bufs.push_back(new DBuffer(usize));
        back = bufs.back()->first;
      }
      --static_cast<DBuffer*>(bufs.back())->ufree;
    }
    char *res = back;
    back += usize;
    ++num;
    return res;
  }

  std::list<CStream> streams;
  std::map<char*, CStream*> prebuilt;

  CStream* createStream(size_t usize)
  {
    streams.emplace_front();
    CStream &s = streams.front();
    {
      s.dynamic = true;
      s.bufs.push_back(new DBuffer(usize));
      s.front = s.bufs.back()->first;
      s.back = s.front;
      s.num = 0;
      s.usize = usize;
    }
    return &s;
  }

  template<typename T>
  CStream* createStream(hls::stream<T> *param)
  {
    CStream *s = createStream(sizeof(T));
    {
      s->dynamic = true;
      while (!param->empty()) {
        T data = param->read();
        memcpy(s->nextWrite(), (char*)&data, sizeof(T));
      }
      prebuilt[s->front] = s;
    }
    return s;
  }

  template<typename T>
  CStream* createStream(T *param, size_t usize)
  {
    streams.emplace_front();
    CStream &s = streams.front();
    {
      s.dynamic = false;
      s.bufs.push_back(new Buffer((char*)param));
      s.front = s.back = s.bufs.back()->first;
      s.usize = usize;
      s.num = ~0UL;
    }
    prebuilt[s.front] = &s;
    return &s;
  }

  CStream* findStream(char *buf)
  {
    return prebuilt.at(buf);
  }
}
class AESL_RUNTIME_BC {
  public:
    AESL_RUNTIME_BC(const char* name) {
      file_token.open( name);
      if (!file_token.good()) {
        cout << "Failed to open tv file " << name << endl;
        exit (1);
      }
      file_token >> mName;//[[[runtime]]]
    }
    ~AESL_RUNTIME_BC() {
      file_token.close();
    }
    int read_size () {
      int size = 0;
      file_token >> mName;//[[transaction]]
      file_token >> mName;//transaction number
      file_token >> mName;//pop_size
      size = atoi(mName.c_str());
      file_token >> mName;//[[/transaction]]
      return size;
    }
  public:
    fstream file_token;
    string mName;
};
using hls::sim::Byte;
struct __cosim_s16__ { char data[16]; };
extern "C" void histoframe_accel(Byte<16>*, Byte<16>*, int, int, int, int, int, int);
extern "C" void apatb_histoframe_accel_hw(volatile void * __xlx_apatb_param_dat_inp, volatile void * __xlx_apatb_param_dat_out, int __xlx_apatb_param_rows_in, int __xlx_apatb_param_cols_in, int __xlx_apatb_param_rows_out, int __xlx_apatb_param_cols_out) {
using hls::sim::createStream;
  // Collect __xlx_dat_inp__tmp_vec
std::vector<Byte<16>> __xlx_dat_inp__tmp_vec;
for (size_t i = 0; i < 115200; ++i){
__xlx_dat_inp__tmp_vec.push_back(((Byte<16>*)__xlx_apatb_param_dat_inp)[i]);
}
  int __xlx_size_param_dat_inp = 115200;
  int __xlx_offset_param_dat_inp = 0;
  int __xlx_offset_byte_param_dat_inp = 0*16;
  // Collect __xlx_dat_out__tmp_vec
std::vector<Byte<16>> __xlx_dat_out__tmp_vec;
for (size_t i = 0; i < 57600; ++i){
__xlx_dat_out__tmp_vec.push_back(((Byte<16>*)__xlx_apatb_param_dat_out)[i]);
}
  int __xlx_size_param_dat_out = 57600;
  int __xlx_offset_param_dat_out = 0;
  int __xlx_offset_byte_param_dat_out = 0*16;
  // DUT call
  histoframe_accel(__xlx_dat_inp__tmp_vec.data(), __xlx_dat_out__tmp_vec.data(), __xlx_offset_byte_param_dat_inp, __xlx_offset_byte_param_dat_out, __xlx_apatb_param_rows_in, __xlx_apatb_param_cols_in, __xlx_apatb_param_rows_out, __xlx_apatb_param_cols_out);
// print __xlx_apatb_param_dat_inp
for (size_t i = 0; i < __xlx_size_param_dat_inp; ++i) {
((Byte<16>*)__xlx_apatb_param_dat_inp)[i] = __xlx_dat_inp__tmp_vec[__xlx_offset_param_dat_inp+i];
}
// print __xlx_apatb_param_dat_out
for (size_t i = 0; i < __xlx_size_param_dat_out; ++i) {
((Byte<16>*)__xlx_apatb_param_dat_out)[i] = __xlx_dat_out__tmp_vec[__xlx_offset_param_dat_out+i];
}
}
