# Create a jump table
def jump_table(s)
  i=0
  t=[-1]
  for i in 1...(s.length)
    t[i]=t[i-1]+1
    # Let's find the first continuation of the proper suffix that is a proper prefix as well
    while t[i]>0 and s[i-1]!=s[t[i]-1]
      t[i]=t[t[i]-1]+1
    end
  end
  return t
end

def substrings(haystack, needle)
  r=[]
  t=jump_table(needle)
  ind=0
  for i in 0...(haystack.length)
    if i-ind==needle.size-1 and haystack[i]==needle[i-ind]
      r << ind
      ind=i-t[i-ind]
    end
    while (i-ind==needle.size-1) or (ind<=i and haystack[i]!=needle[i-ind])
      ind=i-t[i-ind]
    end
  end
  return r
end

p jump_table("ABCABCDE") # -1, 0, 0, 0, 1, 2, 3, 0
p jump_table("PARTICIPATE IN PARACHUTE")
p jump_table("ABCCABCDABCCABCCD") # -1, 0, 0, 0, 1, 2, 3, 0
p substrings("ABCCABCCABCDABCCABCCD", "ABCCABCDABCCABCCD")
p substrings("ABABBAB", "AB")
p substrings("ABC ABCDAB ABCDABCDABDE", "ABCDABD")
p substrings("ABC ABCDAB ABCDABCDABDE", "ABCDEF")
