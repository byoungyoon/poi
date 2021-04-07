package jbt.test.poi.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jbt.test.poi.vo.Memo;

@Mapper
public interface MemoMapper {
	List<String> selectMemoByYearAndMonth(String memoDate);
	int insertMemo(Memo memo);
	int deleteMemo(int memoNo);
	List<Memo> selectMemoByLastUpdate();
	Memo selectMemoOneByDay(String memoDate);
}
