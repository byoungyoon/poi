package jbt.test.poi.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jbt.test.poi.mapper.MemoMapper;
import jbt.test.poi.vo.Memo;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j
public class MemoService {
	@Autowired MemoMapper memoMapper;
	
	public List<Integer> getByYearAndMonth(String memoDate){
		List<Integer> dayList = new ArrayList<Integer>();
		
		List<String> list = memoMapper.selectMemoByYearAndMonth(memoDate);
		
		for(int i=0; i<list.size(); i++) {
			String[] value = list.get(i).split("-");
			int day = Integer.parseInt(value[2]);
			dayList.add(day);
		}
		
		return dayList;
	}
	
	public void addMemo(Memo memo) {
		memoMapper.insertMemo(memo);
	}
	
	public void removeMemo(int memoNo) {
		memoMapper.deleteMemo(memoNo);
	}
	
	public Memo getMemoOneByDay(String memoDate) {
		return memoMapper.selectMemoOneByDay(memoDate);
	}
	
	public List<Memo> getMemoByLastUpdate(){
		return memoMapper.selectMemoByLastUpdate();
	}
}
