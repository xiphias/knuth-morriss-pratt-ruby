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
  ind=0 # Potential position of start of substring
  for i in 0...(haystack.length) # Process search string
    # Did we find the substring?
    if i-ind==needle.size-1 and haystack[i]==needle[i-ind]
      r << ind
      ind=i-t[i-ind]
    end
    
    # Jump to later indices if needed
    while (i-ind==needle.size-1) or (ind<=i and haystack[i]!=needle[i-ind])
      ind=i-t[i-ind]
    end
  end
  return r
end

p jump_table("ABCABCDE") # [-1, 0, 0, 0, 1, 2, 3, 0]
p jump_table("PARTICIPATE IN PARACHUTE") # [-1, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 0, 1, 2, 3, 0, 0, 0, 0, 0]
p jump_table("ABCCABCDABCCABCCD") # [-1, 0, 0, 0, 0, 1, 2, 3, 0, 1, 2, 3, 4, 5, 6, 7, 4]
p substrings("ABCCABCCABCDABCCABCCD", "ABCCABCDABCCABCCD") # [4]
p substrings("ABABBAB", "AB") # [0, 2, 5]
p substrings("ABC ABCDAB ABCDABCDABDE", "ABCDABD") # [15]
p substrings("ABC ABCDAB ABCDABCDABDE", "ABCDEF") # []
