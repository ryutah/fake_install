#!/usr/bin/ruby
# frozen_string_literal: true

require 'securerandom'

def print_progress(total, now, bps)
  rate = now.to_f / total.to_f
  bar_width = 30 * rate
  progress = '#' * bar_width
  info = "#{now.to_i}KB #{bps}KB/s".ljust(15)
  pct = (rate * 100).to_i
  print("\r #{pct.to_s.rjust(3)}% _progress... #{progress.ljust(30)}| #{info}")
end

def download(total, progress)
  bps = (10..200).to_a.sample
  now = progress + bps
  now = total if now > total
  print_progress(total, now, bps)
  now
end

def download_start(filename, total)
  progress = 0
  puts "Downloding #{filename} #{total}KB"

  loop do
    progress = download(total, progress)
    break if progress >= total
    sleep(Random.rand(1.0))
  end
  puts
end

def circle(index)
  circles = %w(- \\ | /)
  circles[index]
end

def install(size)
  (size / 100).times do |i|
    index = i % 3
    print "\rInstalling... #{circle(index)}"
    slp_time = Random.rand(0.5)
    sleep(slp_time)
  end
  puts
end

def file_name
  len = rand(10)
  "#{SecureRandom.hex(len)}.tar.gz"
end

def start
  loop do
    total = (200..4_000).to_a.sample
    download_start(file_name, total)
    install(total)
  end
end

start
