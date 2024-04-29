import yt_dlp
import os
import subprocess
import sys

def download_audio(link):
    with yt_dlp.YoutubeDL({'extract_audio': True, 'format': 'bestaudio', 'outtmpl':'%(title)s.mp3'}) as video:
        info_dict = video.extract_info(link, download = True)

    video_title = info_dict['title']
    video.download(link)    
    command = "ffmpeg -i '" + video_title + ".mkv' '" + video_title + ".mp3'"
    subprocess.run(command, shell=True, capture_output=True, text=True)

if __name__ == "__main__":
    if(len(sys.argv)) == 2:
        download_audio(sys.argv[1])
    else:
        print("Il faut uniquement une url en argument")
